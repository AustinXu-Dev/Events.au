//
//  AllEventsByOrganizerId.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 12/07/2024.
//

import Foundation
//MARK: - this is a method url for fetching events that a user has hosted by userId (not organizerID)
class AllEventsByUserId : APIManager {
    let id : String
    init(id: String) {
        self.id = id
    }
    
    typealias ModelType = AllOrganizersResponse
    
    
    var methodPath: String {
        return "/events/organizer/\(id)"
    }
    
}

