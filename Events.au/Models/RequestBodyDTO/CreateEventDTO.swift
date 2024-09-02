//
//  CreateEventDTO.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation
//JSON
/*
 {
   "name": "Event Name",
   "unitId": "<mongoose _id>"
 }
 */

//MARK: Use this as a body when a user want to create event
struct CreateEventDTO : Codable {
    let name, description, location, startDate, endDate, startTime, endTime, rules, coverImageUrl, unitId: String
    
}
