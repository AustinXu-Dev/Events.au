//
//  UpdateParticipantStatus.swift
//  Events.au
//
//  Created by Akito Daiki on 09/07/2024.
//

import Foundation

class UpdateParticipantStatus: APIManager {
    
    typealias ModelType = ParticipantApprovalDTO
    var eventId: String
    
    init(eventId: String){
        self.eventId = eventId
    }
    
    var methodPath: String {
        return "/org/event/\(eventId)/participant"
    }
}
