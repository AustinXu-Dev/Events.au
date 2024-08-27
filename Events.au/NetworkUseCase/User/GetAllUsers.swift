//
//  GetAllUsers.swift
//  Events.au
//
//  Created by Akito Daiki on 27/08/2024.
//

import Foundation

class GetAllUsers: APIManager {
    
    typealias ModelType = AllUsersResponse
    
    var methodPath: String {
        return "/users/"
    }
}
