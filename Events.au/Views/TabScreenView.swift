//
//  TabScreenView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import SwiftUI

struct TabScreenView: View {
//enum for Tabs, add other tabs if needed
    

    @State private var selectedTab: Tab = .home
    @State private var homeNavigationStack: [HomeNavigation] = []
    @State private var createEventNavigationStack: NavigationPath = .init()
    @State private var profileNavigationStack: [ProfileNavigation] = []
    @StateObject private var authVM : GoogleAuthenticationViewModel = GoogleAuthenticationViewModel()
    @StateObject var profileVM : GetOneUserByIdViewModel = GetOneUserByIdViewModel()
    @Environment(\.colorScheme) var colorMode

    
    var body: some View {

        TabView(selection: $selectedTab) {
            //Home View
            HomeView(path: $homeNavigationStack, profilePath: $profileNavigationStack, selectedTab: $selectedTab)
                .environmentObject(profileVM)
                .tabItem {
                    homeTabLabel
                }
                .tag(Tab.home)
                
            //Create Event View
            CreateEventPreScreen(path: $createEventNavigationStack, selectedTab: $selectedTab)
                .tabItem {
                    remarkTabLabel
                }
                .tag(Tab.createEvent)
         
            //Profile View
            ProfileView(path: $homeNavigationStack, profilePath: $profileNavigationStack, selectedTab: $selectedTab)
                .environmentObject(profileVM)
                .tabItem {
                    profileTabLabel
                }
                .tag(Tab.profile)
        }
        .tint(Theme.tintColor)
        .onAppear {
            customizeTabBarAppearance()
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                profileVM.getOneUserById(id: userId)
            }
        }
        .onChange(of: colorMode) { _, _ in
            customizeTabBarAppearance()

        }
        
    }
}

extension TabScreenView {
    private var homeTabLabel: some View{
        Label("Home", image: selectedTab==Tab.home ? "home_icon_active" : "home_icon")
            .font(Theme.labelFontStyle)
    }
    
    private var remarkTabLabel: some View{
        Label("Event", image: selectedTab==Tab.createEvent ? "create_icon_active" : "create_icon")
            .font(Theme.labelFontStyle)
    }
    
    private var profileTabLabel: some View{
        Label("Profile", image: selectedTab==Tab.profile ? "profile_icon_active" : "profile_icon")
            .font(Theme.labelFontStyle)
    }
    
    private func tabSelection() -> Binding<Tab> {
        Binding { //this is the get block
            self.selectedTab
        } set: { tappedTab in
            if tappedTab == self.selectedTab {
            //User tapped on the currently active tab icon => Pop to root/Scroll to top
                
                if homeNavigationStack.isEmpty{
                    //User already on home view, scroll to top function here
                } else {
                    homeNavigationStack = []
                }
                
                if createEventNavigationStack.isEmpty{
                    
                } else {
                    createEventNavigationStack = NavigationPath()
                }
            }
            //Set the tab to the tabbed tab
            self.selectedTab = tappedTab
        }
    }
    
    // Method to customize tab bar appearance based on light or dark mode
      private func customizeTabBarAppearance() {
          let appearance = UITabBarAppearance()
          appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "TabBarColor")
          UITabBar.appearance().standardAppearance = appearance
          UITabBar.appearance().scrollEdgeAppearance = appearance
      }
    
}

//#Preview {
//    TabScreenView()
//}
