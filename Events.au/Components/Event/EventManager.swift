//
//  EventManager.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 18/06/2024.
//

import SwiftUI

struct EventManager: View {
    
    let events : [EventModel]
    @AppStorage("userRole") private var userRole: String?
    @Binding var showUpcoming : Bool
    @ObservedObject var allEventsVM : AllEventsViewModel
    @ObservedObject var organizerEventsVM : OrganizerEventsViewModel

    
    
    var body: some View {
        VStack(alignment:.center) {
            eventManagerHeader
            if !showUpcoming {
                ScrollView(.vertical,showsIndicators: false) {
                    VStack(alignment:.center,spacing:Theme.medium) {
                        if events.count != 0 {
                            ForEach(events,id: \._id){ event in
                                if event.startDate?.toDate() == Date() {
                                    NavigationLink {
                                        //MARK: -api fetching should happen in this child view using observed object both for events and participants
                                        EventPreEditView(event: event, approvedParticipants: ParticipantMock.instacne.participants, pendingParticipants: ParticipantMock.instacne.participants, unit: UnitMock.instacne.unitA)
                                    } label: {
                                        EventRow(event: event)

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
                        if events.count != 0 {
                            ForEach(events,id: \._id){ event in
                                EventRow(event: event)
                            }
                        } else {
                            noEventsView
                                .offset(y:100)
                        }
                    }.transition(.move(edge: .trailing))
                }
            }
        }
        Spacer(minLength: 0)
            .onAppear(perform: {
                print("App storage userRole in child view is \(String(describing: userRole))")
                if let userId = KeychainManager.shared.keychain.get("appUserId") {

                //get all events based on userRole
                if userRole == UserState.audience.rawValue {
                    self.allEventsVM.fetchEvents()
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
                    HomeTest(path: .constant([]) , selectedTab: .constant(.home))
                } label: {
                    Text("Join Event")
                        .underline()
                        .foregroundStyle(Theme.tintColor)
                }
                
                Text("for more exciting experiences")

            }
        }
    }
}


struct EventManager_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                EventManager(events: EventMock.instacne.allEvents, showUpcoming: .constant(true),allEventsVM : AllEventsViewModel(), organizerEventsVM: OrganizerEventsViewModel())
                    .previewLayout(.sizeThatFits)
                    .preferredColorScheme(.light)
                    .padding()
            }
            NavigationStack {
                EventManager(events:EventMock.instacne.allEvents,showUpcoming: .constant(true),allEventsVM : AllEventsViewModel(), organizerEventsVM: OrganizerEventsViewModel())
                    .previewLayout(.sizeThatFits)
                    .preferredColorScheme(.dark)
                    .padding()
            }
        }
    }
}
