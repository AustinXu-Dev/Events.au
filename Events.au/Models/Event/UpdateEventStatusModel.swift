//
//  UpdateEventStatus.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
{
status*    string
example: pending | approved | active | suspended | cancelled | completed | rejected
One of the Status of the event.

adminId*    string
example: <admin id>
Id of the admin who is updating the status.

}
*/

struct UpdateEventStatusResponse: Codable {
    let success: Bool
    let message: UpdateEventStatusModel
}



struct UpdateEventStatusModel  : Codable {
    
    let status,adminId : String
  
    
    
    
}

