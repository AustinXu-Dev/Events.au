//
//  EventUnitModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
{
eventId*    {
description:
Event ID

name*    string
example: Event name
Name of the event

description*    [...]
startDate*    string
example: 2022-12-31
Start date of the event

endDate*    [...]
startTime*    [...]
endTime*    [...]
location*    [...]
rules*    [...]
coverImageUrL*    [...]
adminId*    [...]
status*    [...]
}
example: <eventId>
unitId*    {
description:
Unit ID

name*    [...]
description*    [...]
}
example: <unitId>
}
*/

//MARK: For getting unit & event relation
struct EventUnitResponse: Codable {
    let success: Bool
    let message: [EventUnitModel]
}

struct EventUnitModel : Codable {
    let _id : String
    let eventId : EventModel
    let unitId : UnitModel
}
