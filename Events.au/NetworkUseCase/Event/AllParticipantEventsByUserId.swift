//
//  AllParticipantEventsByUserId.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 07/08/2024.
//

import Foundation
//MARK: - this is for fetching events that a participant has joined
class AllParticipantEventsByUserId : APIManager {
    let userId : String
    init(userId: String) {
        self.userId = userId
    }
    
    typealias ModelType = AllParticipantsResponse
    
    var methodPath: String {
        return "/events/participant/\(userId)"
    }
    
    
}
