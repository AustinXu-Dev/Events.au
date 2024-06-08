//
//  UnitMemberModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
 {
 userId*    {
 description:
 User ID

 fId*    [...]
 firstName*    [...]
 lastName*    [...]
 email*    [...]
 gender*    [...]
 age*    [...]
 phone*    [...]
 isAdmin*    [...]
 }
 example: <mongoose _id>
 unitId*    {
 description:
 Unit ID

 name*    [...]
 description*    [...]
 }
 example: <mongoose _id>
 }
 */



struct UnitMemberResponse: Codable {
    let success: Bool
    let message: UnitMemberModel
}


struct UnitMemberModel : Codable {
    let userId, unitId : String
    
    
}
