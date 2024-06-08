//
//  UnitAdminModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation


//JSON Model
/*
 {
 adminId*    {
 description:
 Admin ID

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
 example: <userId>
 unitId*    {
 description:
 Unit ID

 name*    [...]
 description*    [...]
 }
 example: <unitId>
 }
 example: adminId
 unitId*    {
 description:
 Unit ID

 name*    [...]
 description*    [...]
 }
 example: unitId
 }
 */



struct UnitAdminResponse: Codable {
    let success: Bool
    let message: UnitAdminModel
}


struct UnitAdminModel : Codable {
    let adminId : AdminModel
    let unitId : UnitModel
    
 

}
