//
//  HomeTest.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import SwiftUI

struct HomeTest: View {
    
    @Binding var path: [HomeNavigation]
    @Binding var profilePath : [ProfileNavigation]
    @Binding var selectedTab: Tab
    @StateObject private var authVM : GoogleAuthenticationViewModel = GoogleAuthenticationViewModel()
    @StateObject private var eventVM : AllEventsViewModel = AllEventsViewModel()
    @StateObject private var profileVM : GetOneUserByIdViewModel = GetOneUserByIdViewModel()
    @StateObject var participantsVM : GetParticipantsByEventIdViewModel = GetParticipantsByEventIdViewModel()
    @State var isSearching: Bool = false
    @State var showingSidebar: Bool = false
    @State var searchText: String = ""
    @State var selectedCategory : [String] = []
    @State var showSignOutAlert: Bool = false
//    @State var tokenIsExpired : Bool = false

    
    // Filtered Events for search text
    var filteredEvents: [EventModel]{
        withAnimation {
            if searchText.isEmpty{
                return eventVM.approvedEvents
            } else{
                return eventVM.approvedEvents.filter { $0.name?.localizedStandardContains(searchText) ?? false}
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
                    if let imageUrl = FirebaseManager.shared.auth.currentUser?.photoURL {
                        RemoteProfileToolBarView(url: "\(imageUrl)")
                    }
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
                        showSignOutAlert = true
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
                    if let user = profileVM.userDetail {
                        EventDetail(user: user, event: currentEvent, path: $path, profilePath: $profilePath, selectedTab: $selectedTab, participantsVM: participantsVM, approvedParticipants: participantsVM.approvedParticipants
                        )
                    }
                case .attendeesList(_):
                    AttendeesListView(approvedParticipants: participantsVM.approvedParticipants)
                case .eventRegistration(let currentEvent):
                    EventRegistrationView(event: currentEvent, path: $path, selectedTab: $selectedTab)
                case .registrationSuccess:
                    EventRegistrationSuccessView(path: $path, selectedTab: $selectedTab)
                default:
                    Text("Navigation Crashed")
                }
            }
            
        }
//        .onReceive(authVM.timer.publisher) { timer in
//            self.tokenIsExpired = true
//        }
        .alert(isPresented: $authVM.tokenIsExpired) {
                    Alert(
                        title: Text("Session Expired"),
                        message: Text("Your session has expired. Please sign in again."),
                        dismissButton: .default(Text("Sign In Again")) {
                            authVM.signOutWithGoogle()
                        }
                    )
                }
        .alert(isPresented: $showSignOutAlert) {
            Alert(
                title: Text("Are you sure you want to sign out?"),
                primaryButton: .destructive(Text("OK")) {
                    authVM.signOutWithGoogle()
                },
                secondaryButton: .cancel()
            )
        }
        .onAppear(perform: {
            //fetch events
            eventVM.fetchEvents()
            
            //fetch currentUser
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                profileVM.getOneUserById(id: userId)
            }
            print("p fetched in hometest",participantsVM.approvedParticipants.count)
        
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
                    //                        ForEach(filteredEvents,id: \._id){ event in
                    //
                    //                            NavigationLink(value: HomeNavigation.eventDetail(event, participantsVM.approvedParticipants)) {
                    //
                    //                                    EventCard(participantsVM: participantsVM, event: event)
                    //                                }
                    //
                    //                            }.tint(Theme.secondaryTextColor)
                    ForEach(filteredEvents.filter { event in
                        if let endDateString = event.endDate,
                           let endTimeString = event.endTime,
                           let eventEndDateTime = combineDateAndTime(dateString: endDateString, timeString: endTimeString) {
                            
                            // Compare using the Calendar API
                            return Calendar.current.compare(eventEndDateTime, to: Date(), toGranularity: .minute) == .orderedDescending
                        }
                        return false
                    }, id: \._id) { event in
                        NavigationLink(value: HomeNavigation.eventDetail(event, participantsVM.approvedParticipants)) {
                            EventCard(participantsVM: participantsVM, event: event)
                                .padding(.bottom,16)
                        }
                        .tint(Theme.secondaryTextColor)
                    }
                    
                    
                    
                }
            }
        }
    }
    func combineDateAndTime(dateString: String, timeString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.timeZone = TimeZone.current
        
        let combinedString = "\(dateString) \(timeString)"
        return dateFormatter.date(from: combinedString)
    }
}


#Preview {
    HomeTest(path: .constant([]), profilePath: .constant([]), selectedTab: .constant(.home))
}
