//
//  UserCreatePoll.swift
//  Events.au
//
//  Created by Austin Xu on 2024/7/23.
//

import Foundation

class UserCreatePoll: APIManager {
    typealias ModelType = PollDTO
    var methodPath: String {
        return "/user/create/poll"
    }
}
