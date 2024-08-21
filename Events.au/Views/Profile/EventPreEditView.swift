//
//  EventDetailsView.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 19/6/2567 BE.
//

import SwiftUI

struct EventPreEditView: View {
    
    let event : EventModel
    let unit : UnitModel
    //for accessing the users device light/dark mode
    @Environment(\.colorScheme) var colorScheme
    @Binding var path : [HomeNavigation]
    @Binding var profilePath: [ProfileNavigation]
    @ObservedObject var participantVM : GetParticipantsByEventIdViewModel
    @Binding var selectedTab: Tab
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(alignment: .leading,spacing:Theme.defaultSpacing) {
                eventImage
                eventDetails
                NavigationLink {
                    EventParticipantManagementView(event: event, unit: unit)
                } label: {
                    participantsOverview
                }
            }
        } //End of Scroll View
        .padding(.horizontal,Theme.large)
        .navigationBarTitle("Event Details", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                toolBarPencil
            }
        }
        .onAppear {
            if let eventId = event._id {
                participantVM.fetchParticipants(id: eventId)
            }
        }
    }
}

extension EventPreEditView {
    
    private var eventImage : some View {
        RemoteImage(url: event.coverImageUrl ?? "no_image")
//        Image("event_details")
//            .resizable()
//            .frame(width: Theme.eventImageWidth,height: Theme.eventImageHeight)
    }
    
    private var eventDetails : some View {
        VStack(alignment: .leading, spacing: Theme.headingBodySpacing) {
            ProfileDetailRow(label: "Name", value: event.name ?? "")
            ProfileDetailRow(label: "Faculty", value: unit.name ?? "Unknown faculty")
            ProfileDetailRow(label: "Start Date", value: event.startDate ?? "")
            ProfileDetailRow(label: "End Date", value: event.endDate ?? "")
            ProfileDetailRow(label: "From", value: event.startTime ?? "")
            ProfileDetailRow(label: "To", value: event.endTime ?? "")
            ProfileDetailRow(label: "Description", value: event.description ?? "No description")
        }
    }
    
    private var toolBarPencil : some View {
//        NavigationLink(destination: EventDetailsEditView(event: event, unit: UnitMock.instacne.unitA,path: $path,profilePath: $profilePath,selectedTab: $selectedTab)) {
//            Image(colorScheme == .light ? Theme.lightModePencil : Theme.darkModePencil)
//                .frame(width:Theme.iconWidth,height:Theme.iconHeight)
//        }
        NavigationLink(value: ProfileNavigation.orgEventDetailEditView(event, unit)) {
            Image(colorScheme == .light ? Theme.lightModePencil : Theme.darkModePencil)
                .frame(width:Theme.iconWidth,height:Theme.iconHeight)
        }
    }
    
    private var participantsOverview : some View {
        
        RoundedRectangle(cornerRadius: Theme.cornerRadius)
            .foregroundStyle(Theme.backgroundColor)
            .applyThemeDoubleShadow()
            .frame(width: Theme.eventImageWidth,height: Theme.participantSquareImage)
            .overlay(alignment: .leading, content: {
                VStack(alignment:.leading) {
                    Text("Participants")
                        .foregroundStyle(Theme.secondaryTextColor)
                        .applyLabelFont()
                    HStack(spacing:Theme.medium) {
                        EventParticipants(participants: participantVM.approvedParticipants, participantStatus: "joining")
                            .foregroundStyle(Theme.secondaryTextColor)
                        EventParticipants(participants: participantVM.pendingParticipants, participantStatus: "pending")
                            .foregroundStyle(Theme.tintColor)
                    }
                }
                .padding(.horizontal,Theme.medium)
                .padding(.vertical,Theme.small)
            })
    }
}

#Preview {
    NavigationStack {
        EventPreEditView(event: EventMock.instacne.eventA, unit: UnitMock.instacne.unitA,path: .constant([]), profilePath: .constant([]), participantVM: GetParticipantsByEventIdViewModel(),selectedTab: .constant(.profile))
    }
}
