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

//MARK: Use this as a request body for updating event status => approve or reject
struct UpdateEventStatusDTO  : Codable {
    let status,adminId : String
}

