//
//  CreatePollView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/30.
//

import SwiftUI

struct CreatePollView: View {
    
    @Binding var path: NavigationPath
    @Binding var selectedTab: Tab
    @State var isEditing: Bool = false
    
    @ObservedObject var pollVM: CreatePollViewModel

    var body: some View {
        GeometryReader{ geometry in
            ScrollView {
                ForEach(pollVM.polls) { poll in
                    PollView(poll: poll, pollVM: pollVM, isEditing: $isEditing)
                }
                HStack{
                    Spacer()
                    Button(action: {
                        pollVM.polls.append(PollDTO())
                    }, label: {
                        Text("New Poll")
                            .frame(width: 93, height: 40)
                            .foregroundStyle(Theme.primaryTextColor)
                            .applyButtonFont()
                            .background(
                                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                                    .frame(height:Theme.buttonHeight)
                                    .foregroundStyle(Theme.tintColor)
                            )
                    })
                }.padding(.horizontal, 16)
                
                Spacer().frame(height: 75)
                
                Button {
                    print(pollVM.polls[0].title)
                } label: {
                    Text("Get all poll")
                }
                
                Button {
                    pollVM.createPoll(token: TokenManager.share.getToken() ?? "")
                } label: {
                    Text("Post Poll")
                }
                
                NavigationLink(value: "Congrats") {
                    Text("Create Event")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Theme.primaryTextColor)
                        .applyButtonFont()
                        .padding(.vertical, Theme.medium)
                        .background(
                            RoundedRectangle(cornerRadius: Theme.cornerRadius)
                                .frame(height:Theme.buttonHeight)
                                .foregroundStyle(Theme.tintColor)
                        )
                        .padding(.horizontal, Theme.large)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height) // Make ScrollView span the full screen
            
            .navigationBarBackButtonHidden()
            .navigationTitle("Create Poll")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        path.removeLast()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Theme.tintColor)
                    })
                }
            }
            .onReceive(pollVM.$polls) { polls in
                if polls.isEmpty {
                    pollVM.polls.append(PollDTO())
                }
            }
            
        }.onTapGesture {
            withAnimation {
                pollVM.editingPollIndex = -1
            }
            isEditing = false
        }
        
    }
}

#Preview {
    CreatePollView(
        path: .constant(NavigationPath.init()),
        selectedTab: .constant(Tab.createEvent), pollVM: CreatePollViewModel()
    )
}
