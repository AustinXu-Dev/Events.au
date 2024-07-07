//
//  ParticipantByEventId.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 08/07/2024.
//

import Foundation

class GetParticipantByEventId : APIManager {
    let eventId : String
    init(eventId: String) {
        self.eventId = eventId
    }
    typealias ModelType = AllParticipantsResponse
    
    var methodPath: String {
        return "/participants/event/\(eventId)"
    }

    
    
    
    
}
