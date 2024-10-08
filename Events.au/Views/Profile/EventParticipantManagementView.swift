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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventParticipantManagementView(unit: UnitMock.instacne.unitA)
//    }
//}


//    HStack(spacing: 0) {
//                        Spacer()
//
//                        GeometryReader { geometry in
//                            VStack {
//                                Text("Current")
//                                    .fontWeight(.bold)
//                                    .padding(.vertical, 10)
//                                    .padding(.horizontal, 35)
//                                    .background(
//                                        VStack(spacing: 0) {
//                                            Spacer()
//                                            if self.index == 1 {
//                                                Rectangle()
//                                                    .fill(Color.eventBackground)
//                                                    .frame(width: geometry.size.width, height: 2)
//                                            }
//                                        }
//                                            .padding(.leading, 10)
//                                    )
//                                    .onTapGesture {
//                                        withAnimation(.default) {
//                                            self.index = 1
//                                        }
//                                    }
//                            }
//                        }
//                        .padding(.leading, 16)
//                        .frame(height: 40)
//
//                        Spacer()
//
//                        GeometryReader { geometry in
//                            VStack {
//                                Text("Pending")
//                                    .fontWeight(.bold)
//                                    .padding(.vertical, 10)
//                                    .padding(.horizontal, 35)
//                                    .background(
//                                        VStack(spacing: 0) {
//                                            Spacer()
//                                            if self.index == 2 {
//                                                Rectangle()
//                                                    .fill(Color.eventBackground)
//                                                    .frame(width: geometry.size.width, height: 2)
//                                                    .padding(.leading, 10)
//                                            }
//                                        }
//                                    )
//                                    .onTapGesture {
//                                        withAnimation(.default) {
//                                            self.index = 2
//                                        }
//                                    }
//                            }
//                        }
//                        .frame(height: 40)
//
//                        Spacer()
//                    }
//                    .padding(.top, 16)
//                    .padding(.bottom, 12)
//
//                    if index == 1 {
//                        GridView(participants: currentParticipants)
//                    } else if index == 2 {
//                        GridView(participants: pendingParticipants)
//                    }
//                    Spacer()

//#Preview {
//    EventParticipantManagementView(event: EventMock.instacne.eventA, showPending: false, pendingParticipants: ParticipantMock.instacne.participants, approvedParticipants: ParticipantMock.instacne.participants, unit: UnitMock.instacne.unitA)
//}
