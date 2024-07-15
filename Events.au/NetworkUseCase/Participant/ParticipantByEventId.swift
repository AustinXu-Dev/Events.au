//
//  ParticipantByEventId.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 08/07/2024.
//

import Foundation

class GetParticipantByEventId : APIManager {
    let id : String
    init(id: String) {
        self.id = id
    }
    typealias ModelType = AllParticipantsResponse
    
    var methodPath: String {
        return "/participants/event/\(id)"
    }

    
}


