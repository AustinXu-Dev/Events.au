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
    
    var body: some Scene {
        WindowGroup {
            ConfirmationView()
        }
    }
}
