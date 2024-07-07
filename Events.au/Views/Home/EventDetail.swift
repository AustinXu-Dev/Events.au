//
//  EventDetail.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 22/06/2024.
//

import SwiftUI

struct EventDetail: View {
    let event : EventModel
    let approvedParticipants : [ParticipantModel]
    @Binding var path: [HomeNavigation]
    @Binding var selectedTab: Tab
    @StateObject private var eventUnitsVM : GetUnitsByEventViewModel = GetUnitsByEventViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var isParagraph : Bool = false
    
    var body: some View {
        
        //MARK: - for consideration :
        /*
         Should we fetch the eventUnits since the beginning at home view and pass it down to its child views. Even though we don't need it at home view, we don't need to put loader in this view that way.
         */
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
                    if approvedParticipants.count >= 8 {
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
                        
                        
                        
                        
                        
                    }
                    registerButton
                        .padding(.vertical,8)
                }
            }
        }
        .padding(.horizontal,Theme.large)
        .onAppear(perform: {
            if let eventId = event._id {
                eventUnitsVM.getUnitsByEvent(id: eventId)
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
            EventParticipants(participants: approvedParticipants, participantStatus: "joining")
                .applyHeadingFont()
            
        }
        
        
        
        
    }
    
    private var registerButton : some View {
        //        Button {
        //            print("Hello")
        //        } label: {
        //            Text("Register Now")
        //                .applyButtonFont()
        //                .foregroundStyle(Theme.primaryTextColor)
        //                .padding(.horizontal,Theme.large)
        //                .frame(maxWidth: .infinity)
        //                .frame(height: 40)
        //                .background(RoundedRectangle(cornerRadius: Theme.cornerRadius))
        //                .foregroundStyle(Theme.tintColor)
        //        }
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
    
}


#Preview {
    NavigationStack {
        EventDetail(event: EventMock.instacne.eventA, approvedParticipants: ParticipantMock.instacne.participants, path: .constant([]), selectedTab: .constant(.home))
    }
    .padding(.horizontal,Theme.large)
    
}


