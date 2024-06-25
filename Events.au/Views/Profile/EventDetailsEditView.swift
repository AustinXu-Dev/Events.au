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
    
    @State private var event : EventModel = EventMock.instacne.eventA
    @State private var unit : UnitModel = UnitMock.instacne.unitA
    @State private var name: String
    @State private var faculty: String
    @State private var startDate: String
    @State private var endDate: String
    @State private var from: String
    @State private var to: String
    @State private var description: String
    
    init() {
        //MARK: after we get the view model the event and unit has to be changed
        let event = EventMock.instacne.eventA
        let unit = UnitMock.instacne.unitA
        _name = State(initialValue: event.name)
        _faculty = State(initialValue: unit.name ?? "No Faculty")
        _startDate = State(initialValue: event.startDate)
        _endDate = State(initialValue: event.endDate)
        _from = State(initialValue: event.startTime)
        _to = State(initialValue: event.endTime)
        _description = State(initialValue: event.description)
    }
    
    var body: some View {
        
        ScrollView(.vertical,showsIndicators: false) {
            VStack(spacing:Theme.defaultSpacing) {
                eventImage
                eventDetails
                Button(action: {
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
                TextField("", text: $name)
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("Faculty")
                    .applyHeadingFont()
                Spacer()
                TextField("", text: $faculty)
                    .applyBodyFont()
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("Start Date")
                    .applyHeadingFont()
                Spacer()
                TextField("", text: $startDate)
                    .applyBodyFont()
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("End Date")
                    .applyHeadingFont()
                Spacer()
                TextField("", text: $endDate)
                    .applyBodyFont()
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("From")
                    .applyHeadingFont()
                Spacer()
                TextField("", text: $from)
                    .applyBodyFont()
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("To")
                    .applyHeadingFont()
                Spacer()
                TextField("", text: $to)
                    .applyBodyFont()
                    .frame(maxWidth: Theme.textFieldWidth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack(alignment:.top) {
                Text("Description")
                    .applyHeadingFont()
                Spacer()
                TextField("", text: $description,axis: .vertical)
                    .applyBodyFont()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: Theme.textFieldWidth)
                    .lineLimit(10,reservesSpace: true)
                
                
            }
        }
        .padding(.horizontal,Theme.large)
        
        
        
    }
}



#Preview {
    NavigationStack {
        EventDetailsEditView()
    }
}
