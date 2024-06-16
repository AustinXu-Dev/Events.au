//
//  UnitAdminModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation


//MARK: For getting the unit and admin relation
struct UnitAdminResponse: Codable {
    let success: Bool
    let message: UnitAdminModel
}

struct UnitAdminModel : Codable {
    let _id : String
    let adminId : AdminModel
    let unitId : UnitModel
}


