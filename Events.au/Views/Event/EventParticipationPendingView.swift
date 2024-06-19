//
//  EventParticipationPendingView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 17/6/2567 BE.
//

import SwiftUI

struct EventParticipationPendingView: View {
    @State private var index = 1
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading) {
                    Spacer().frame(height: 20)
                    
                    HStack {
                        Spacer()
                        Image("event_details")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Spacer()
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

                    HStack(spacing: 0) {
                        Spacer()
                        
                        GeometryReader { geometry in
                            VStack {
                                Text("Current")
                                    .fontWeight(.bold)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 35)
                                    .background(
                                        VStack(spacing: 0) {
                                            Spacer()
                                            if self.index == 1 {
                                                Rectangle()
                                                    .fill(Color.eventBackground)
                                                    .frame(width: geometry.size.width, height: 2)
                                            }
                                        }
                                            .padding(.leading, 10)
                                    )
                                    .onTapGesture {
                                        withAnimation(.default) {
                                            self.index = 1
                                        }
                                    }
                            }
                        }
                        .padding(.leading, 16)
                        .frame(height: 40)
                        
                        Spacer()
                        
                        GeometryReader { geometry in
                            VStack {
                                Text("Pending")
                                    .fontWeight(.bold)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 35)
                                    .background(
                                        VStack(spacing: 0) {
                                            Spacer()
                                            if self.index == 2 {
                                                Rectangle()
                                                    .fill(Color.eventBackground)
                                                    .frame(width: geometry.size.width, height: 2)
                                                    .padding(.leading, 10)
                                            }
                                        }
                                    )
                                    .onTapGesture {
                                        withAnimation(.default) {
                                            self.index = 2
                                        }
                                    }
                            }
                        }
                        .frame(height: 40)
                        
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 12)
                    
                    if index == 1 {
                        GridView(participants: currentParticipants)
                    } else if index == 2 {
                        GridView(participants: pendingParticipants)
                    }
                    Spacer()
                }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EventParticipationPendingView()
    }
}
