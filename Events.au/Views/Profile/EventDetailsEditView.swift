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
                        
                        if let eventId = event._id {
                            updateEventViewModel.updateEventBasicInfo(eventId: eventId, token: TokenManager.share.getToken() ?? "")
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            alertMessage = "You successfully edited the event."
                            showConfirmationAlert = true
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
            RemoteImage(url: event.coverImageUrl ?? "")
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
