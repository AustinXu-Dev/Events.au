//
//  OrganizerModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
userId*    {...}
example: <userId>
eventId*    {...}
example: <eventId>
status*    [...]
}
*/

//MARK: Use this to get one organizer
struct OrganizerResponse: Codable {
    let success: Bool
    let message: OrganizerModel
}

//MARK: Use this to get all organizers
struct AllOrganizersResponse: Codable {
    let success: Bool
    let message: [OrganizerModel]
}

struct OrganizerModel  : Codable {
    let _id, userId,eventId : String
    let status : String
}
