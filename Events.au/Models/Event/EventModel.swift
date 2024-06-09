//
//  EventModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
 
 
 name*    string
 example: Event name
 Name of the event
 
 description*    string
 example: Event description
 Description of the event
 
 startDate*    string
 example: 2022-12-31
 Start date of the event
 
 endDate*    string
 example: 2022-12-31
 End date of the event
 
 startTime*    string
 example: 08:00
 Start time of the event
 
 endTime*    string
 example: 17:00
 End time of the event
 
 location*    string
 example: John Paul II
 Location of the event
 
 rules*    string
 example: No alcohol
 Rules of the event
 
 coverImageUrL*    string
 example: Event cover image URL
 Cover image URL of the event
 
 adminId*    string
 example: <mongoose _id>
 Admin ID
 
 status*    string
 example: pending | approved | active | suspended | cancelled | completed | rejected
 Status of the event
 */

struct EventResponse: Codable {
    let success: Bool
    let message: EventModel
}


struct EventModel : Codable {
    
    let _id,name,description,startDate,endDate,startTime,endTime,
        location,rules,coverImageUrL,adminId,status : String
    
}
