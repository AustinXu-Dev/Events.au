//
//  CreateEventPreScreen.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/28.
//

import SwiftUI

struct CreateEventPreScreen: View {
    
    @Binding var path: NavigationPath
    @Binding var selectedTab: Tab
    @ObservedObject var pollVM = PollViewModel()
    

    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment:.center,spacing:Theme.defaultSpacing){
                Image(Theme.eventauText)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 300, maxHeight: 35)
                Image(Theme.createEventImage)
                    .resizable()
                    .frame(width: 361, height: 246)
                    .scaledToFill()
                Text("Simply submit your event for approval and watch as your idea transform into a memorable experience for attendees.")
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .applyBodyFont()
                    .padding(.horizontal)
                NavigationLink(value: CreateEventNavigation.fillEventData) {
                    ReusableButton(title: "Host an Event")
                }
            }
            
            //MARK: - CONTROL NAVIGATION HERE
            .navigationDestination(for: CreateEventNavigation.self) { screen in
                switch screen{
                case .preScreen:
                    CreateEventPreScreen(path: $path, selectedTab: $selectedTab)
                case .fillEventData:
                    CreateEventView(path: $path, selectedTab: $selectedTab, createEventViewModel: CreateEventViewModel())
                case .createPoll:
                    CreatePollView(path: $path, selectedTab: $selectedTab, pollVM: pollVM)
                case .congrats:
                    CreateEventSuccessView(path: $path, selectedTab: $selectedTab, pollVM: pollVM)
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        CreateEventPreScreen(
            path: .constant(NavigationPath.init()),
            selectedTab: .constant(Tab.createEvent)
        )
    }
}
