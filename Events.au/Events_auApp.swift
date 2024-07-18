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
    
    var body: some Scene {
        WindowGroup {
            Group{
                if isSingIn {
                    NavigationStack {
                        TabScreenView()
                    }
//                    ProfileView()
                } else {
                    SignInView()
                }
            }
        }
    }
}
