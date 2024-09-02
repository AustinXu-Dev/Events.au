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
    @ObservedObject var pollVM = CreatePollViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment:.center,spacing:Theme.defaultSpacing){
                Image(colorScheme == .light ? Theme.eventauText : Theme.eventauTextDarkMode)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 300, maxHeight: 35)
                Image(colorScheme == .light ? Theme.createEventImage : Theme.createEventImageDarkMode)
                    .resizable()
                    .frame(width: 361, height: 246)
                    .scaledToFill()
                Text("Simply submit your event for approval and watch as your idea transform into a memorable experience for attendees.")
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .applyBodyFont()
                    .padding(.horizontal)
                NavigationLink(value: "FillEventData") {
                    ReusableButton(title: "Host an Event")
                }
            }
            
            //MARK: - CONTROL NAVIGATION HERE
            .navigationDestination(for: String.self) { screen in
                switch screen{
                case "FillEventData":
                    CreateEventView(path: $path, selectedTab: $selectedTab, createEventViewModel: CreateEventViewModel())
                case "CreatePoll":
                    CreatePollView(path: $path, selectedTab: $selectedTab, pollVM: pollVM)
                case "Congrats":
                    CreateEventSuccessView(path: $path, selectedTab: $selectedTab, pollVM: pollVM)
                default:
                    Text("")
                }
            }
//            .navigationDestination(for: CreateEventNavigation.self) { screen in
//                switch screen{
//                case .preScreen:
//                    CreateEventPreScreen(path: $path, selectedTab: $selectedTab)
//                case .fillEventData:
//                    CreateEventView(path: $path, selectedTab: $selectedTab, createEventViewModel: CreateEventViewModel())
//                case .createPoll:
//                    CreatePollView(path: $path, selectedTab: $selectedTab, pollVM: pollVM)
//                case .congrats:
//                    CreateEventSuccessView(path: $path, selectedTab: $selectedTab, pollVM: pollVM)
//                }
//            }
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
