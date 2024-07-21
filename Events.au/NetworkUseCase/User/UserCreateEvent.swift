//
//  UserCreateEvent.swift
//  Events.au
//
//  Created by Akito Daiki on 21/07/2024.
//

import Foundation

class UserCreateEvent: APIManager {
    typealias ModelType = CreateEventDTO
    var methodPath: String {
        return "/user/create/event"
    }
}
