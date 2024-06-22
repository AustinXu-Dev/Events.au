//
//  AdminModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation
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
example: <userId>
unitId*    {
description:
Unit ID

name*    [...]
description*    [...]
}
example: <unitId>
}
*/

//MARK: For getting a specific admin
struct AdminResponse : Codable {
    let success: Bool
    let message: AdminModel
}

//MARK: For getting all admins
struct AllAdminResponse: Codable {
    let success: Bool
    let message: [AdminModel]
}

struct AdminModel : Codable {
    let _id : String
    let userId : UserModel
    let unitId : UnitModel
}
