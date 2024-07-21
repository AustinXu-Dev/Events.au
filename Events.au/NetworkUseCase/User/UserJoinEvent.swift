//
//  UserJoinEvent.swift
//  Events.au
//
//  Created by Akito Daiki on 09/07/2024.
//

import Foundation

class UserJoinEvent: APIManager {
    
    typealias ModelType = ParticipantApprovalDTO
    var id: String
    
    init(id: String){
        self.id = id
    }
    
    var methodPath: String {
        return "/user/join/event/\(id)"
    }
}
