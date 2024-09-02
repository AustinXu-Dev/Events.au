//
//  UpdateEventUnitModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
 action*    string
 example: remove
 Action to perform

 units*    [
 example: List [ "<unitId>" ]
 Unit IDs

 string]
 }
 */


//MARK: Use this as a request body for updating units of an event
struct UpdateEventUnitDTO : Codable {
    let action : String
    let units : [String]
}


