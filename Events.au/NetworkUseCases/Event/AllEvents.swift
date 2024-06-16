//
//  AllEvents.swift
//  Events.au
//
//  Created by Akito Daiki on 16/06/2024.
//

import Foundation

class AllEvents: APIManager {
    typealias ModelType = AllEventsResponse
    var methodPath: String {
        return "/events"
    }
}
