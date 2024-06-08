//
//  UnitModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation
//JSON Model
/*
 {
 name*    string
 example: Unit Name
 Name of the unit

 description*    string
 example: Unit Description
 Description of the unit

 } */


struct UnitResponse: Codable {
    let success: Bool
    let message: UnitModel
}


struct UnitModel  : Codable {
    
    let _id,name,description : String
    
}


