//
//  EventDetailsView.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 19/6/2567 BE.
//

import SwiftUI

struct OrganizedEventDetails: View {
    let event : EventModel
    let approvedParticipants : [ParticipantModel]
    let pendingParticipants : [ParticipantModel]
    //for accessing the users device light/dark mode
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(alignment: .leading,spacing:Theme.defaultSpacing) {
                eventImage
                eventDetails
                participantsOverview
            }
        } //End of Scroll View
        .padding(.horizontal,Theme.large)
        .navigationBarTitle("Event Details", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                toolBarPencil
            }
        }
    }
}

extension OrganizedEventDetails {
    
    private var eventImage : some View {
        Image("event_details")
            .resizable()
            .frame(width: Theme.eventImageWidth,height: Theme.eventImageHeight)
    }
    
    private var eventDetails : some View {
        VStack(alignment: .leading, spacing: Theme.headingBodySpacing) {
            ProfileDetailRow(label: "Name", value: event.name ?? "")
            ProfileDetailRow(label: "Faculty", value: "VMES")
            ProfileDetailRow(label: "Start Date", value: event.startDate ?? "")
            ProfileDetailRow(label: "End Date", value: event.endDate ?? "")
            ProfileDetailRow(label: "From", value: event.startTime ?? "")
            ProfileDetailRow(label: "To", value: event.endTime ?? "")
            ProfileDetailRow(label: "Description", value: event.description ?? "No description")
        }
    }
    
    private var toolBarPencil : some View {
        NavigationLink(destination: EventDetailsEditView()) {
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
                        EventParticipants(participants: approvedParticipants, participantStatus: "joining")
                            .foregroundStyle(Theme.secondaryTextColor)
                        EventParticipants(participants: pendingParticipants, participantStatus: "pending")
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
        OrganizedEventDetails(event: EventMock.instacne.eventA, approvedParticipants: ParticipantMock.instacne.participants, pendingParticipants: ParticipantMock.instacne.participants)
    }
}
