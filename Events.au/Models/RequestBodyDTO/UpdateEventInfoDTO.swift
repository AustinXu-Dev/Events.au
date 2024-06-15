//
//  UpdateEventDTOModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
 {
   "name": "Event Name",
   "organizer": "Event Description",
   "status": "string"
 }
*/

//MARK: Use this as a request body for updating event basic info
struct UpdateEventInfoDTO : Codable {
    let name : String
    let organizer : OrganizerModel
    let status : String
}

