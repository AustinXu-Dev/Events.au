//
//  Events_auApp.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/6.
//

import SwiftUI

@main
struct Events_auApp: App {
   
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var homeNavigationStack: [HomeNavigation] = []
    @AppStorage("appState") var isSingIn = false
    
    init(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.9960784314, green: 1, blue: 1, alpha: 1)
       UITabBar.appearance().standardAppearance = appearance
       UITabBar.appearance().scrollEdgeAppearance = appearance
            
        }
    
    var body: some Scene {
        
        
        WindowGroup {
            
            Group{
                
                
                if isSingIn {
//                    NavigationStack {
                    TabScreenView()
//                    }
//                    ProfileView()
//                    TestView()
                } else {
                    SignInView()
                }
            }
        }
    }
}
