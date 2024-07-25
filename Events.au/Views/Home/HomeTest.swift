//
//  HomeTest.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import SwiftUI

struct HomeTest: View {
    
    @Binding var path: [HomeNavigation]
    @Binding var selectedTab: Tab
    @StateObject private var authVM : GoogleAuthenticationViewModel = GoogleAuthenticationViewModel()
    @StateObject private var eventVM : AllEventsViewModel = AllEventsViewModel()
    @StateObject private var profileVM : GetOneUserByIdViewModel = GetOneUserByIdViewModel()
    @StateObject var participantsVM : GetParticipantsByEventIdViewModel = GetParticipantsByEventIdViewModel()
    @State var isSearching: Bool = false
    @State var showingSidebar: Bool = false
    @State var searchText: String = ""
    @State var selectedCategory : [String] = []
    
    // Filtered Events for search text
    var filteredEvents: [EventModel]{
        withAnimation {
            if searchText.isEmpty{
                return eventVM.events
            } else{
                return eventVM.events.filter { $0.name?.localizedStandardContains(searchText) ?? false}
            }
        }
    }
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(alignment:.leading,spacing:Theme.defaultSpacing){

                SearchBar(searchText: $searchText, isFiltering: $showingSidebar)
                if searchText.isEmpty {
                    categoryScrollView
                }
                if eventVM.loader {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tint(Theme.tintColor)
                } else {
                    eventsScrollView
                }
                                
            }
            .padding(.horizontal,Theme.large)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Image("human_profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    if let userName = profileVM.userDetail?.firstName {
                        Text(userName)
                            .applyHeadingFont()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
//                    Image("noti_icon_active")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                    //MARK: -This will be the sign out button during the development phase
                    Button {
                        authVM.signOutWithGoogle()
                    } label: {
                        Text("Log Out")
                            .applyOverlayFont()
                            .foregroundStyle(Color.red)
                    }

                }
            }
            //MARK: - HOME NAVIGATION HANDLER HERE
            .navigationDestination(for: HomeNavigation.self) { screen in
                switch screen {
                case .eventDetail(let currentEvent, _):
                    EventDetail(event: currentEvent, path: $path, selectedTab: $selectedTab, approvedParticipants: participantsVM.approvedParticipants)
                case .attendeesList(let approvedParticipantsList):
                    AttendeesListView(approvedParticipants: approvedParticipantsList)
                case .eventRegistration(let currentEvent):
                    EventRegistrationView(event: currentEvent, path: $path, selectedTab: $selectedTab)
                case .registrationSuccess:
                    EventRegistrationSuccessView(path: $path, selectedTab: $selectedTab)
                default:
                    Text("Navigation Crashed")
                }
            }
            
        }
        .onAppear(perform: {
            //fetch events
            eventVM.fetchEvents()
            
            //fetch currentUser
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                profileVM.getOneUserById(id: userId)
            }
        
        })
        .tint(.blue)
        .clipped() // Solution for tabbar bug
    }
}



extension HomeTest {
    private var categoryScrollView : some View {
        VStack(alignment: .leading) {
            Text("Categories")
                .applyLabelFont()
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing:Theme.defaultSpacing) {
                    ForEach(CategoryValue.categories,id:\.id) { category in
                        VStack(alignment:.center,spacing:4) {
                            Circle()
                                .frame(height:54)
                                .scaleEffect(selectedCategory.contains(category.id) ? 1.1 : 1)
                                .padding(.vertical,Theme.xs)
                                .foregroundStyle(selectedCategory.contains(category.id) ? Theme.redFaint : Color.white)
                                .applyThemeDoubleShadow()
                                .overlay(
                                    Image(category.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width:Theme.categoryImageFrame,height:Theme.categoryImageFrame)
                                )
                                .applyThemeDoubleShadow()
                            Text(category.name)
                                .applyOverlayFont()
                                .foregroundStyle(selectedCategory.contains(category.id) ? Theme.tintColor : Theme.secondaryTextColor)
                        }
                        .onTapGesture {
                            withAnimation(.spring(duration:0.5)) {
                                if self.selectedCategory.contains(category.id) {
                                    selectedCategory.removeAll(where: {$0 == category.id})
                                } else {
                                    self.selectedCategory.append(category.id)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal,Theme.large)
            }
        }
    }
    
    private var eventsScrollView : some View {
        VStack(alignment:.leading,spacing: Theme.defaultSpacing) {
            Text(searchText.isEmpty ? "Upcoming Events" : "Search results")
                .applyLabelFont()
                ScrollView(.vertical,showsIndicators: false){
                    VStack(alignment:.leading,spacing:Theme.defaultSpacing) {
                        ForEach(filteredEvents,id: \._id){ event in
                            // Change here
                            NavigationLink(value: HomeNavigation.eventDetail(event, participantsVM.approvedParticipants)) {
                                EventCard(participantsVM: participantsVM, event: event)
                            }.tint(Theme.secondaryTextColor)
                                
                        }
                        
                    }
                }
        }
    }
}

#Preview {
    HomeTest(path: .constant([]), selectedTab: .constant(.home))
}
