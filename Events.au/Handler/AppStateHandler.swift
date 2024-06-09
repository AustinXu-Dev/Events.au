//
//  AppStateHandler.swift
//  Events.au
//
//  Created by Akito Daiki on 09/06/2024.
//

import Foundation

struct AppStateHandler {
    
    static func saveAccountAvailability(userId: String){
        UserDefaults.standard.set(userId, forKey: "ExistedAccount")
    }
}
