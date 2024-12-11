//
//  EventDetailsEditView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 17/6/2567 BE.
//
//
//  EventDetailsEditView.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 24/6/2567 BE.
//

import SwiftUI

struct EventDetailsEditView: View {
    let event: EventModel
    let unit: UnitModel
    @State var name: String = ""
    @State var faculty: String = ""
    @State var startDate: String = ""
    @State var endDate: String = ""
    @State var from: String = ""
    @State var to: String = ""
    @State var description: String = ""
    @State var coverImageUrl: String = ""
    
    @State var selectedOptionIndex: Int = 0
    @State var showDropDown: Bool = false
    
    @StateObject var updateEventViewModel = UpdateEventBasicInfoViewModel()
    @StateObject var getAllUnitsViewModel = AllUnitsViewModel()
    
    @Binding var path: [HomeNavigation]
    @Binding var profilePath: [ProfileNavigation]
    @Binding var selectedTab: Tab
    
    @State private var showAlert: Bool = false
    @State private var showConfirmationAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.dismiss) var dismiss
    
    @State private var showImagePicker: Bool = false
    @State private var avatarImage: UIImage?
    
    @StateObject var profileVM = GetOneUserByIdViewModel()
    @State var isLoading: Bool = false
    @State var showNotValidAlert: Bool = false
    @State var errorMessage: String = ""
    @State var showErrorAlert: Bool = false
    
    init(event: EventModel, unit: UnitModel, path: Binding<[HomeNavigation]>, profilePath: Binding<[ProfileNavigation]>, selectedTab: Binding<Tab>) {
        self.event = event
        self.unit = unit
        _path = path
        _profilePath = profilePath
        _selectedTab = selectedTab
        _name = State(initialValue: event.name ?? "")
        _faculty = State(initialValue: unit.name ?? "")
        _startDate = State(initialValue: event.startDate ?? "")
        _endDate = State(initialValue: event.endDate ?? "")
        _from = State(initialValue: event.startTime ?? "")
        _to = State(initialValue: event.endTime ?? "")
        _description = State(initialValue: event.description ?? "No description")
        _coverImageUrl = State(initialValue: event.coverImageUrl ?? "")
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: Theme.defaultSpacing) {
                eventImage
                eventDetails
                
                Button(action: {
                    // Perform validation
                    if validateFields() {
                        updateEventViewModel.name = name
                        updateEventViewModel.unitId = ""
                        updateEventViewModel.startDate = startDate
                        updateEventViewModel.endDate = endDate
                        updateEventViewModel.startTime = from
                        updateEventViewModel.endTime = to
                        updateEventViewModel.description = description
                        
                        guard let userDetail = profileVM.userDetail else {
                            alertMessage = "User details not found."
                            showAlert = true
                            return
                        }
                        
                        let uid = userDetail._id ?? ""
                        let email = userDetail.email ?? ""
                        
                        
                        if let newImage = avatarImage {
                            updateEventViewModel.uploadImage(newImage) { result in
                                switch result {
                                case .success(let imageUrl):
                                    updateEventViewModel.storeImageUrl(imageUrl: imageUrl, uid: uid, email: email) { result in
                                        switch result {
                                        case .success:
                                            updateEventViewModel.retrieveImageUrl(uid: uid) { result in
                                                switch result {
                                                case .success(let storedImageUrl):
                                                    updateEventViewModel.coverImageUrl = storedImageUrl
                                                    if let eventId = event._id, !updateEventViewModel.coverImageUrl.isEmpty {
                                                        updateEventViewModel.updateEventBasicInfo(eventId: eventId, token: TokenManager.share.getToken() ?? "")
                                                    }
                                                    DispatchQueue.main.async {
                                                        withAnimation {
                                                            isLoading = false
                                                        }
                                                        //showAlert = true
                                                        alertMessage = "You successfully edited the event"
                                                        showConfirmationAlert = true
                                                    }
                                                case .failure:
                                                    DispatchQueue.main.async {
                                                        withAnimation {
                                                            isLoading = false
                                                            errorMessage = "Failed to retrieve image URL."
                                                            showErrorAlert = true
                                                        }
                                                    }
                                                }
                                            }
                                        case .failure:
                                            DispatchQueue.main.async {
                                                withAnimation {
                                                    isLoading = false
                                                    errorMessage = "Failed to store image URL."
                                                    showErrorAlert = true
                                                }
                                            }
                                        }
                                    }
                                case .failure:
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            isLoading = false
                                            errorMessage = "Failed to upload image."
                                            showErrorAlert = true
                                        }
                                    }
                                }
                            }
                        } else {
                            updateEventViewModel.coverImageUrl = coverImageUrl
                            if let eventId = event._id {
                                updateEventViewModel.updateEventBasicInfo(eventId: eventId, token: TokenManager.share.getToken() ?? "")
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                alertMessage = "You successfully edited the event."
                                showConfirmationAlert = true
                            }
                        }
                    }
                }) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Theme.tintColor)
                        .cornerRadius(Theme.cornerRadius)
                        .padding(.horizontal)
                }
                .alert(alertMessage, isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
                .alert(alertMessage, isPresented: $showConfirmationAlert){
                    Button {
                        path = []
                        profilePath = []
                        self.dismiss()
                        selectedTab = .profile
                    } label: {
                        Text("Ok")
                    }
                }
            }
            .navigationBarTitle("Event Details", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(Theme.clickedPencil)
                        .imageScale(.large)
                }
            }
        }
        .fullScreenCover(isPresented: $showImagePicker) {
            PhotoPicker(avatarImage: $avatarImage)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onAppear{
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                //get user
                profileVM.getOneUserById(id: userId)
            }
        }
    }
    
    private func validateFields() -> Bool {
        // Check for empty fields
        if name.isEmpty || faculty.isEmpty || startDate.isEmpty || endDate.isEmpty || from.isEmpty || to.isEmpty || description.isEmpty {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return false
        }
        
        // Validate date format (dd-MM-yyyy)
        if !isValidDateFormat(startDate) || !isValidDateFormat(endDate) {
            alertMessage = "Please enter a valid date in the format dd-MM-yyyy."
            showAlert = true
            return false
        }
        
        // Validate time format (HH:mm)
        if !isValidTimeFormat(from) || !isValidTimeFormat(to) {
            alertMessage = "Please enter a valid time in the format HH:mm."
            showAlert = true
            return false
        }
        
        return true
    }
    
    private func isValidDateFormat(_ date: String) -> Bool {
        let dateRegex = "^\\d{2}-\\d{2}-\\d{4}$"
        let datePredicate = NSPredicate(format: "SELF MATCHES %@", dateRegex)
        return datePredicate.evaluate(with: date)
    }
    
    private func isValidTimeFormat(_ time: String) -> Bool {
        let timeRegex = "^\\d{2}:\\d{2}$"
        let timePredicate = NSPredicate(format: "SELF MATCHES %@", timeRegex)
        return timePredicate.evaluate(with: time)
    }
    
    
    private func isValidDate(_ date: String, format: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: date) != nil
    }
    
    private func isValidTime(_ time: String, format: String) -> Bool {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = format
        return timeFormatter.date(from: time) != nil
    }
}

extension EventDetailsEditView {
    private var eventImage: some View {
        HStack {
            if let selectedImage = avatarImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .frame(width: 361, height: 180)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } else {
                RemoteImage(url: event.coverImageUrl ?? "")
            }
        }
        .onTapGesture {
            showImagePicker = true
        }
    }
    
    private var eventDetails: some View {
        VStack(alignment: .leading, spacing: Theme.headingBodySpacing) {
            HStack {
                Text("Name")
                    .applyHeadingFont()
                Spacer()
                TextField(event.name ?? "", text: $name)
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Faculty")
                    .applyHeadingFont()
                Spacer()
                DropDownMenu(
                    options: getAllUnitsViewModel.units,
                    menuWidth: .constant(200),
                    selectedOptionIndex: $selectedOptionIndex,
                    showDropdown: $showDropDown
                )
                .frame(maxWidth: Theme.textFieldWidth)
            }
            .onAppear {
                getAllUnitsViewModel.fetchUnits()
            }
            
            HStack {
                Text("Start Date")
                    .applyHeadingFont()
                Spacer()
                TextField(event.startDate ?? "", text: $startDate)
                    .applyBodyFont()
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("End Date")
                    .applyHeadingFont()
                Spacer()
                TextField(event.endDate ?? "", text: $endDate)
                    .applyBodyFont()
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("From")
                    .applyHeadingFont()
                Spacer()
                TextField(event.startTime ?? "", text: $from)
                    .applyBodyFont()
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("To")
                    .applyHeadingFont()
                Spacer()
                TextField(event.endTime ?? "", text: $to)
                    .applyBodyFont()
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack(alignment: .top) {
                Text("Description")
                    .applyHeadingFont()
                Spacer()
                TextField(event.description ?? "", text: $description, axis: .vertical)
                    .applyBodyFont()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: Theme.textFieldWidth)
                    .lineLimit(10, reservesSpace: true)
            }
        }
        .padding(.horizontal, Theme.large)
    }
}

//#Preview {
//    NavigationStack {
//        EventDetailsEditView(event: EventMock.instacne.eventA, unit: UnitMock.instacne.unitA, name: "", faculty: "", startDate: "", endDate: "", from: "", to:" ", description: "")
//    }
//}
