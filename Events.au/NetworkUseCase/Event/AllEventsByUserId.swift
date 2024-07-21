//
//  AllEventsByOrganizerId.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 12/07/2024.
//

import Foundation

class AllEventsByUserId : APIManager {
    let id : String
    init(id: String) {
        self.id = id
    }
    
    typealias ModelType = AllEventsResponse
    
    
    var methodPath: String {
        return "/events?userId=\(id)"
    }
    
}
