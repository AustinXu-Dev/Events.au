//
//  EventDetail.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 22/06/2024.
//

import SwiftUI

struct EventDetail: View {
    let user : UserModel2
    let event : EventModel
    @Binding var path: [HomeNavigation]
    @Binding var selectedTab: Tab
    @StateObject private var eventUnitsVM : GetUnitsByEventViewModel = GetUnitsByEventViewModel()
    @StateObject private var participantVM = GetParticipantsByEventIdViewModel()
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isParagraph : Bool = false
    let approvedParticipants : [ParticipantModel]
    
    var body: some View {
        
        //MARK: - for consideration :
        ScrollView(.vertical,showsIndicators: false) {
            if eventUnitsVM.loader {
                ProgressView()
            } else {
                VStack(alignment:.leading,spacing: Theme.headingBodySpacing) {
                    eventImage
                    details
                    Divider()
                        .foregroundStyle(Theme.tintColor)
                }
                VStack(alignment:.center) {
                    dateAndLocation
                }
                VStack(alignment:.leading) {
                    if approvedParticipants.count > 0 {
                        NavigationLink {
                            AttendeesListView(approvedParticipants: approvedParticipants)
                        } label: {
                            RoundedRectangle(cornerRadius: Theme.cornerRadius)
                                .foregroundStyle(Theme.backgroundColor)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .frame(height: 80)
                                .applyThemeDoubleShadow()
                                .overlay (
                                    HStack {
                                        attendees
                                            .tint(Theme.secondaryTextColor)
                                        Spacer()
                                    }
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                )
                        }
                        
                    } // end of condition
                    
                    
                    if participantVM.participantExists(userId: user._id) {
                        alreadyRegisteredButton
                            .padding(.vertical, 8)
                    } else {
                        registerButton
                            .padding(.vertical, 8)
                    }
                }
            }
        }
        .padding(.horizontal,Theme.large)
        .onAppear(perform: {
            if let eventId = event._id {
                //fetching units by eventID
                eventUnitsVM.getUnitsByEvent(id: eventId)
                //fetching participants of an event
                participantVM.fetchParticipants(id: eventId)
            }
            
        })
        
        
    }
}


extension EventDetail {
    private var eventImage : some View {
        Image(Theme.eventImage)
            .resizable()
            .frame(width: Theme.eventImageWidth,height: Theme.eventImageHeight)
            .scaledToFill()
    }
    private var details : some View {
        VStack(alignment:.leading,spacing: Theme.headingBodySpacing) {
            Text(event.name ?? "")
                .applyLabelFont()
            HStack {
                ForEach(eventUnitsVM.eventUnits,id:\._id){ eventUnit in
                    Text(eventUnit.unitId.name ?? "Unknown Faculty")
                        .applyMediumFont()
                        .foregroundStyle(Theme.tintColor)
                }
            }
            VStack(alignment:.leading,spacing:Theme.xs) {
                Text(event.description ?? "This event has no description.")
                    .applyBodyFont()
                    .lineLimit(isParagraph ? .max : 6)
                
                if event.description != nil {
                    Button {
                        withAnimation(.default) {
                            self.isParagraph.toggle()
                        }
                    } label: {
                        Text(isParagraph ? "see less" : "read more")
                            .foregroundStyle(Theme.tintColor)
                            .applyOverlayFont()
                    }
                } //end of condition
            }
        }
    }
    
    private var dateAndLocation : some View {
        HStack(spacing:65) {
            VStack(alignment:.center) {
                if let startDate = event.startDate?.toDate()?.formatDateOnly(), let endDate = event.endDate?.toDate()?.formatDateOnly(), let eventMonth = event.startDate?.toDate()?.formatMonthOnly() {
                    Text("\(startDate) - \(endDate)")
                        .applyHeadingFont()
                        .foregroundStyle(Theme.tintColor)
                    Text("\(eventMonth)")
                        .applyHeadingFont()
                        .foregroundStyle(Theme.secondaryTextColor)
                }
            }
            .padding(8)
            .background(RoundedRectangle(cornerRadius: Theme.cornerRadius))
            .foregroundStyle(Color.white)
            .applyThemeDoubleShadow()
            
            VStack(alignment:.leading,spacing:Theme.small) {
                if let startTime = event.startTime, let endTime = event.endTime {
                    HStack(spacing:Theme.headingBodySpacing) {
                        Image(systemName: Theme.clock)
                            .resizable()
                            .frame(width: Theme.iconWidth,height: 18)
                            .scaledToFill()
                        
                        Text("\(startTime)-\(endTime)")
                            .applyMediumFont()
                    }
                }
                
                HStack(spacing:Theme.headingBodySpacing) {
                    if let location = event.location {
                        Image(colorScheme == .light ? Theme.locationLight : Theme.locationDark)
                            .resizable()
                            .frame(width: Theme.iconWidth,height: 18)
                            .scaledToFill()
                        Text(location)
                            .applyMediumFont()
                    }
                }
            }
        }
        .padding(8)
    }
    
    
    private var attendees : some View {
        
        VStack(alignment:.leading,spacing: Theme.small) {
            
            Text("Participants")
                .applyHeadingFont()
            EventParticipants(participants:approvedParticipants, participantStatus: "joining")
                .applyHeadingFont()
            
        }
        
        
        
        
    }
    
    private var registerButton : some View {
        NavigationLink(value: HomeNavigation.eventRegistration(event)) {
            Text("Register Now")
                .applyButtonFont()
                .foregroundStyle(Theme.primaryTextColor)
                .padding(.horizontal,Theme.large)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(RoundedRectangle(cornerRadius: Theme.cornerRadius))
                .foregroundStyle(Theme.tintColor)
        }
        
    }
    
    private var alreadyRegisteredButton : some View {
        ZStack {
            RoundedRectangle(cornerRadius: Theme.cornerRadius)
            Text("Already Registered")
                .applyButtonFont()
                .foregroundStyle(Theme.primaryTextColor)
                .padding(.horizontal,Theme.large)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(RoundedRectangle(cornerRadius: Theme.cornerRadius))
                .foregroundStyle(Theme.tintColor)
        }
        
        
        
    }
    
}


#Preview {
    NavigationStack {
        EventDetail(user: UserMock.instance.user3, event: EventMock.instacne.eventA, path: .constant([]), selectedTab: .constant(.home), approvedParticipants: ParticipantMock.instacne.participants)
    }
    .padding(.horizontal,Theme.large)
    
}


