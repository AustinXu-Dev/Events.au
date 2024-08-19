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
    
    let event : EventModel
    let unit: UnitModel
    @State  var name: String = ""
    @State  var faculty: String = ""
    @State  var startDate: String = ""
    @State  var endDate: String = ""
    @State  var from: String = ""
    @State  var to: String = ""
    @State  var description: String = ""
    
    @State var selectedOptionIndex: Int = 0
    @State var showDropDown: Bool = false
    
    @StateObject  var updateEventViewModel = UpdateEventBasicInfoViewModel()
    @StateObject var getAllUnitsViewModel = AllUnitsViewModel()
    
    
    
    @Binding var path : [HomeNavigation]
    @Binding var profilePath: [ProfileNavigation]

    @Binding var selectedTab: Tab
    
    
    init(event : EventModel, unit: UnitModel, path: Binding<[HomeNavigation]>, profilePath: Binding<[ProfileNavigation]>, selectedTab: Binding<Tab>) {
        //MARK: after we get the view model the event and unit has to be changed
        self.event = event
        self.unit  = unit
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
        
        ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:Theme.defaultSpacing) {
                eventImage
                eventDetails
                Button(action: {
                    // HAS: I have to pass the selected event id from Profile View here!!!
                    
    
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
                .alert("Your event is updated successfully.", isPresented: $updateEventViewModel.showAlert) {
//                    NavigationLink(value: ProfileNavigation.profile) {
//                        ProfileView(path: $path, profilePath: $profilePath, selectedTab: $selectedTab)
//                    }
                    Button("Confirm") {
                        profilePath = []
                        selectedTab = .profile
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
}

extension EventDetailsEditView {
    private var eventImage : some View {
        HStack {
            Image("event_details")
                .resizable()
                .frame(height:Theme.eventImageHeight)
                .frame(maxWidth: .infinity)
                .scaledToFill()
                .padding(.horizontal,Theme.large)

        }
    }
    
    private var eventDetails : some View {
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
            .onAppear{
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
            
            HStack(alignment:.top) {
                Text("Description")
                    .applyHeadingFont()
                Spacer()
                TextField(event.description ?? "", text: $description,axis: .vertical)
                    .applyBodyFont()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: Theme.textFieldWidth)
                    .lineLimit(10,reservesSpace: true)
            }
        }
        .padding(.horizontal,Theme.large)
    }
}



//#Preview {
//    NavigationStack {
//        EventDetailsEditView(event: EventMock.instacne.eventA, unit: UnitMock.instacne.unitA, name: "", faculty: "", startDate: "", endDate: "", from: "", to:" ", description: "")
//    }
//}
