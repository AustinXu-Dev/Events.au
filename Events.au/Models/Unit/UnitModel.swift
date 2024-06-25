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

//MARK: Use this to get a unit
struct UnitResponse: Codable {
    let success: Bool
    let message: UnitModel
}

//MARK: Use this to get all units
struct AllUnitsResponse: Codable {
    let success: Bool
    let message: [UnitModel]
}

struct UnitModel: Codable {
    let id : String
    let name: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case description
    }
}
