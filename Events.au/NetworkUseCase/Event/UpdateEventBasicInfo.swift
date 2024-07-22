//
//  UpdateEventBasicInfo.swift
//  Events.au
//
//  Created by Akito Daiki on 21/07/2024.
//

import Foundation

class UpdateEventBasicInfo: APIManager {
    
    typealias ModelType = UpdateEventInfoDTO
    var eventId: String
    
    init(eventId: String){
        self.eventId = eventId
    }
    
    var methodPath: String {
        return "/org/event/\(eventId)/basic-info"
    }
}
