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
    
    var body: some View {
  
        TabView(selection: tabSelection()) {
            //Home View
            HomeTest(path: $homeNavigationStack)
                .tabItem {
                    homeTabLabel
                }
                .tag(Tab.home)
                
            //Remark View
            Text("Remark")
                .tabItem {
                    remarkTabLabel
                }
                .tag(Tab.remarks)
         
            //Profile View
            Text("Profile")
                .tabItem {
                    profileTabLabel
                }
                .tag(Tab.profile)
        }
        .tint(Theme.tintColor)
    }
}

extension TabScreenView {
    private var homeTabLabel: some View{
        Label("Home", image: selectedTab==Tab.home ? "home_icon_active" : "home_icon")
            .font(Theme.labelFontStyle)
    }
    
    private var remarkTabLabel: some View{
        Label("Remarks", image: selectedTab==Tab.remarks ? "remark_icon_active" : "remark_icon")
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
                } else{
                    homeNavigationStack = []
                }
            }
            //Set the tab to the tabbed tab
            self.selectedTab = tappedTab
        }
    }
}

#Preview {
    TabScreenView()
}
