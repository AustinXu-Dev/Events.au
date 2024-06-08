//
//  EventDTOModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation


// JSON Model
/*
 name*    string
 example: Event Name
 Name of the event

 unitId*    string
 example: <mongoose _id>
 Unit ID
 */

struct EventDTOResponse: Codable {
    let success: Bool
    let message: EventDTOModel
}


struct EventDTOModel  : Codable {
    let name,unitId : String
}
