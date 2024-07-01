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
    
    @ObservedObject var pollVM: PollViewModel

    var body: some View {
        GeometryReader{ geometry in
            ScrollView {
                ForEach(pollVM.polls) { poll in
                    PollView(poll: poll, pollVM: pollVM)
                }
                HStack{
                    Spacer()
                    Button(action: {
                        pollVM.polls.append(PollModel())
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
                
//                Button(action: {
//                    for i in pollVM.polls{
//                        print(i.pollTitle, i.options, i.allowMultipleAnswer)
//                    }
//                }, label: {
//                    Text("Create Event")
//                        .frame(maxWidth: .infinity)
//                        .foregroundStyle(Theme.primaryTextColor)
//                        .applyButtonFont()
//                        .padding(.vertical, Theme.medium)
//                        .background(
//                            RoundedRectangle(cornerRadius: Theme.cornerRadius)
//                                .frame(height:Theme.buttonHeight)
//                                .foregroundStyle(Theme.tintColor)
//                        )
//                        .padding(.horizontal, Theme.large)
//                })
                NavigationLink(value: CreateEventNavigation.congrats) {
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
                    pollVM.polls.append(PollModel())
                }
            }
            
        }.onTapGesture {
            withAnimation {
                pollVM.editingPollIndex = -1
            }
        }
        
    }
}

#Preview {
    CreatePollView(
        path: .constant(NavigationPath.init()),
        selectedTab: .constant(Tab.createEvent), pollVM: PollViewModel()
    )
}
