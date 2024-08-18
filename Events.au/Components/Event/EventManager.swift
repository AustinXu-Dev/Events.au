//
//  EventManager.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 18/06/2024.
//

import SwiftUI

struct EventManager: View {
    
 
    @AppStorage("userRole") private var userRole: String?
    @Binding var showUpcoming : Bool
    @ObservedObject var participantEventsVM : ParticipantEventsViewModel
    @ObservedObject var organizerEventsVM : OrganizerEventsViewModel
    @StateObject var participantVM : GetParticipantsByUserIdViewModel = GetParticipantsByUserIdViewModel()

    @Binding var path : [HomeNavigation]
    @Binding var profilePath: [ProfileNavigation]
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack(alignment:.center) {
            eventManagerHeader
            
            if userRole == UserState.audience.rawValue {
            //MARK: - for audience, fetch participants
            if !showUpcoming {
                ScrollView(.vertical,showsIndicators: false) {
                    VStack(alignment:.center,spacing:Theme.medium) {
                        if !participantEventsVM.participantEvents.isEmpty {
                            ForEach(participantEventsVM.participantEvents,id: \._id){ participant in
                                if let event = participant.eventId {
                                    if ((event.startDate?.toDate()?.strippedTime() == Date().strippedTime())) {
                                        ForEach(participantVM.participant) { fetchedParticipant in
                                            NavigationLink(value: ProfileNavigation.eventDetail(event, ParticipantMock.instacne.participantA )) {
                                                EventRow(event: event,participant: fetchedParticipant)
                                                    .tint(Color.black)
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            noEventsView
                                .offset(y:100)
                        }
                    }.transition(.move(edge: .leading))
                }
            }
            if showUpcoming {
                ScrollView(.vertical,showsIndicators: false) {
                    VStack(alignment:.center,spacing:Theme.medium) {
                        if !participantEventsVM.participantEvents.isEmpty {
                            ForEach(participantEventsVM.participantEvents,id: \._id){ participant in
                                if let event = participant.eventId {
                                    if ((event.startDate?.toDate()?.strippedTime() != Date().strippedTime())) {
                                        ForEach(participantVM.participant) { fetchedParticipant in
                                            NavigationLink(value: ProfileNavigation.eventDetail(event, ParticipantMock.instacne.participantA) ) {
                                                EventRow(event: event,participant: fetchedParticipant)
                                                    .tint(Color.black)
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            noEventsView
                                .offset(y:100)
                        }
                    }.transition(.move(edge: .trailing))
                }
            }
            } else {
                //MARK: - for organizer, fetch events
                if !showUpcoming {
                    ScrollView(.vertical,showsIndicators: false) {
                        VStack(alignment:.center,spacing:Theme.medium) {
                             let organizerEvents = organizerEventsVM.organizerEvents
                                if organizerEvents.count != 0 {
                                    ForEach(organizerEvents,id: \._id){ organizer in
                                        if let event = organizer.eventId {
                                            if ((event.startDate?.toDate()?.strippedTime() == Date().strippedTime())) {
                                                ForEach(participantVM.participant) { fetchedParticipant in
                                                    NavigationLink {
                                                        //MARK: -api fetching should happen in this child view using observed object both for events and participants
                                                        EventPreEditView(event: event, approvedParticipants: ParticipantMock.instacne.participants, pendingParticipants: ParticipantMock.instacne.participants, unit: UnitMock.instacne.unitA)
                                                    } label: {
                                                        //mock data is passed for participant arguement here, since there's nothing to do with participant for an organizer
                                                        EventRow(event: event,participant: fetchedParticipant)
                                                            .tint(Color.black)
                                                    }
                                                    
                                                }
                                            }
                                    }
                                }
                            } else {
                                noOrganizedEventsView
                                    .offset(y:100)
                            }
                        
                        }.transition(.move(edge: .leading))
                    }
                }
                if showUpcoming {
                    ScrollView(.vertical,showsIndicators: false) {
                        VStack(alignment:.center,spacing:Theme.medium) {
                            let organizerEvents = organizerEventsVM.organizerEvents
                            if organizerEvents.count != 0 {
                                ForEach(organizerEvents,id: \._id){ organizer in
                                    if let event = organizer.eventId {
                                        if ((event.startDate?.toDate()?.strippedTime() != Date().strippedTime())) {
                                            //mock data is passed for participant arguement here, since there's nothing to do with participant for an organizer
                                            ForEach(participantVM.participant) { fetchedParticipant in
                                                NavigationLink {
                                                    EventPreEditView(event: event, approvedParticipants: ParticipantMock.instacne.participants, pendingParticipants: ParticipantMock.instacne.participants, unit: UnitMock.instacne.unitA)
                                                } label: {
                                                    EventRow(event: event,participant: fetchedParticipant)
                                                        .tint(Color.black)
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                noOrganizedEventsView
                                    .offset(y:100)
                            }
                        
                        }.transition(.move(edge: .trailing))
                    }
                }
            }
        } // end of VStack
        Spacer(minLength: 0)
            .onAppear(perform: {
                print("App storage userRole in child view is \(String(describing: userRole))")
                if let userId = KeychainManager.shared.keychain.get("appUserId") {
                    participantVM.fetchParticipant(id: userId)
                //get all events based on userRole
                if userRole == UserState.audience.rawValue {
                    self.participantEventsVM.fetchEvents(userId: userId)
                } else {
                    self.organizerEventsVM.fetchEventsByOrganizer(id: userId)
                }
            }
                
                })
    }
    
    
}

extension EventManager {
    private var eventManagerHeader : some View {
        HStack {
            VStack(alignment:.center) {
                Text("Ongoing")
                    .applyLabelFont()
                    .onTapGesture {
                        withAnimation {
                            self.showUpcoming = false
                        }
                    }
                Rectangle()
                    .foregroundStyle(Theme.tintColor)
                    .frame(width:150,height:3)
                    .opacity(showUpcoming ? 0 : 1)
            }
            Spacer(minLength: 0)
            VStack(alignment:.center) {
                Text("Upcoming")
                    .applyLabelFont()
                    .onTapGesture {
                        withAnimation {
                            self.showUpcoming = true
                        }
                    }
                Rectangle()
                    .foregroundStyle(Theme.tintColor)
                    .frame(width:150,height:3)
                    .opacity(showUpcoming ? 1 : 0)
            }
            
        }
    }
    private var noEventsView : some View {
        VStack(alignment:.center,spacing:Theme.defaultSpacing) {
            Image(Theme.noEventVector)
                .resizable()
                .scaledToFit()
                .frame(width: 100,height: 100)
                .applyThemeDoubleShadow()
            Text("No Event Upcoming")
                .applyLabelFont()
            HStack {
                NavigationLink {
                    HomeTest(path: $path, profilePath: $profilePath , selectedTab: .constant(.home))
                } label: {
                    Text("Join Event")
                        .underline()
                        .foregroundStyle(Theme.tintColor)
                }

                
                
                Text("for more exciting experiences")

            }
        }
    }
    
    private var noOrganizedEventsView : some View {
        VStack(alignment:.center,spacing:Theme.defaultSpacing) {
            Image(Theme.noEventVector)
                .resizable()
                .scaledToFit()
                .frame(width: 100,height: 100)
                .applyThemeDoubleShadow()
            Text("No Event Upcoming")
                .applyLabelFont()
            HStack {
//                NavigationLink {
//                    CreateEventPreScreen(path: .constant(.init()), selectedTab: .constant(.createEvent))
//                } label: {
//                    Text("Host Event")
//                        .underline()
//                        .foregroundStyle(Theme.tintColor)
//                }
                
                
                Button {
                    path = []
                    selectedTab = .createEvent
                } label: {
                    Text("Host Event")
                        .underline()
                        .foregroundStyle(Theme.tintColor)
                }
                Text("to make exciting experiences")

            }
        }
    }
    
}


struct EventManager_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                EventManager(showUpcoming: .constant(true),participantEventsVM : ParticipantEventsViewModel(), organizerEventsVM: OrganizerEventsViewModel(),path: .constant([]), profilePath:.constant([]), selectedTab: .constant(.profile))
                    .previewLayout(.sizeThatFits)
                    .preferredColorScheme(.light)
                    .padding()
            }
            NavigationStack {

                EventManager(showUpcoming: .constant(true),participantEventsVM : ParticipantEventsViewModel(), organizerEventsVM: OrganizerEventsViewModel(),path: .constant([]), profilePath:.constant([]), selectedTab: .constant(.profile))
                    .previewLayout(.sizeThatFits)
                    .preferredColorScheme(.dark)
                    .padding()
            }
        }
    }
}
