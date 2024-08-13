//
//  EventStatusColor.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 17/06/2024.
//

import Foundation
import SwiftUI

struct EventStatus {
    static let instance = EventStatus()
    private init() { }
    
    func colorHandler(status:String) -> Color {
        switch status {
        case "approved" :
            return Color(Theme.approvedEventColor)
        case "pending" :
            return Color(Theme.pendingEventColor)
        case "rejected" :
            return Color(Theme.redFaint)
        case "active" :
            return Color(Theme.approvedEventColor)
        case "completed":
            return Color(Theme.pendingEventColor)
        default:
            return Color(Theme.pendingEventColor)

        }
    }
    
}

