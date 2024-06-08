//
//  UpdateEventDTOModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
name*    string
example: Event Name
Name of the event

organizer*    {...}
example: Event Description
status*    [...]
}
*/

struct UpdateEventResponse: Codable {
    let success: Bool
    let message: UpdateEventModel
}



struct UpdateEventModel  : Codable {
    
    let name : String
    let eventId : String
    let status : String
    
    
}

