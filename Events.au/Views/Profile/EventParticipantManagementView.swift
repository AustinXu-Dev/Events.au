//
//  EventParticipationPendingView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 17/6/2567 BE.
//

import SwiftUI

struct EventParticipantManagementView: View {
    @State private var index = 1
    @State var showPending : Bool = false
    @State var pendingParticipants : [ParticipantModel] = ParticipantMock.instacne.participants
    @State var approvedParticipants : [ParticipantModel] = ParticipantMock.instacne.participants
    let unit : UnitModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false) {
                VStack (alignment: .leading,spacing: Theme.defaultSpacing) {
                  
                    HStack {
                      
                        Image("event_details")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                      
                    }
                    .padding([.leading, .trailing], 16)
                    .padding(.bottom, 20)
                    
                    if self.index == 1 {
                        Text("Event Participants")
                            .font(.system(size: 20))
                            .bold()
                            .padding(.horizontal, 16)
                    } else if self.index == 2 {
                        Text("Participants")
                            .font(.system(size: 20))
                            .bold()
                            .padding(.horizontal, 16)
                    }
                    ParticipantManager(showPending: $showPending, unit: unit, pendingParticipants: $pendingParticipants, approvedParticipants: $approvedParticipants)
                }
               
            }
            
            .padding(.horizontal,Theme.large)
            
                .navigationBarTitle("Event Details", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: EditProfileView()) {
                            Image(systemName: "pencil")
                                .imageScale(.large)
                        }
                    }
                }
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
