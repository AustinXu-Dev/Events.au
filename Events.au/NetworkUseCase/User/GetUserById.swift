//
//  GetUserById.swift
//  Events.au
//
//  Created by Akito Daiki on 23/06/2024.
//

import Foundation

class GetUserById: APIManager {
    
    typealias ModelType = UserResponse
    var id: String
    
    init(id: String){
        self.id = id
    }
    
    var methodPath: String {
        return "/user/\(id)"
    }
}
