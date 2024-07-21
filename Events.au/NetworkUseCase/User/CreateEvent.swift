//
//  CreateEvent.swift
//  Events.au
//
//  Created by Akito Daiki on 22/06/2024.
//

import Foundation

class CreateEvent: APIManager {
    typealias ModelType = CreateEventDTO
    var methodPath: String {
        return "/user/create/event"
    }
}
