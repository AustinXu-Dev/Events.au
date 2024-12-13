//
//  EventParticipationPendingView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 17/6/2567 BE.
//

import SwiftUI

struct EventParticipantManagementView: View {
    let event : EventModel
    @State private var index = 1
    @State var showPending : Bool = false
    let unit : UnitModel
    @StateObject var participantVM = GetParticipantsByEventIdViewModel()
    @StateObject var approvalVM = UpdateParticipantStatusViewModel()


    
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false) {
                VStack (alignment: .leading,spacing: Theme.defaultSpacing) {
                    HStack(spacing:Theme.small) {
                        Image(Theme.participantIcon)
                            .resizable()
                            .frame(width: Theme.iconWidth,height: Theme.iconHeight)
                            .scaledToFill()
                        Text("\(participantVM.approvedParticipants.count) Attending")
                            .applyHeadingFont()
                            .foregroundStyle(Theme.tintColor)
                        Text("(\(participantVM.pendingParticipants.count) pending)")
                            .applyOverlayFont()
                            .foregroundStyle(Theme.secondaryTextColor.opacity(0.5))
                    }
                    
                    ParticipantManager(event: event ,showPending: $showPending, unit: unit, participantVM: participantVM, approvalVM: approvalVM)
                }
                
            }
            
            .padding(.horizontal,Theme.large)
            
                .navigationBarTitle("Event Details", displayMode: .inline)
                
            }
        
    }
}

struct Participant: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let imageName: String
}

let currentParticipants = [
    Participant(name: "John Doe", role: "VMES", imageName: "PersonD"),
    Participant(name: "Jane Smith", role: "VMES", imageName: "PersonE")
]

let pendingParticipants = [
    Participant(name: "Chris Johnson", role: "VMES", imageName: "PersonD"),
    Participant(name: "Patricia Brown", role: "VMES", imageName: "PersonE")
]
