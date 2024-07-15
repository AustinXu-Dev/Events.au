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
    //MARK: have to remove these state var and replace with view model publishers
    @State var pendingParticipants : [ParticipantModel] = ParticipantMock.instacne.participants
    @State var approvedParticipants : [ParticipantModel] = ParticipantMock.instacne.participants
    let unit : UnitModel
    @StateObject var participantVM = GetParticipantsByEventIdViewModel()

    
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
                        Text("(\(participantVM.allParticipants.count) pending)")
                            .applyOverlayFont()
                            .foregroundStyle(Theme.secondaryTextColor.opacity(0.5))
                    }
                    
                    ParticipantManager(event: event ,showPending: $showPending, unit: unit, pendingParticipants: $pendingParticipants, approvedParticipants: $approvedParticipants,participantVM: participantVM)
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

#Preview {
    EventParticipantManagementView(event: EventMock.instacne.eventA, showPending: false, pendingParticipants: ParticipantMock.instacne.participants, approvedParticipants: ParticipantMock.instacne.participants, unit: UnitMock.instacne.unitA)
}
