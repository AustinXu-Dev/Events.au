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



struct UpdateEventUnitResponse: Codable {
    let success: Bool
    let message: UpdateEventUnitModel
}


struct UpdateEventUnitModel : Codable {
    
    let action : String
    let units : [String]
    
    
}


