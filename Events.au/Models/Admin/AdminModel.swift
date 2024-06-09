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




struct AdminResponse: Codable {
    let success: Bool
    let message: AdminModel
}

struct AdminModel : Codable {
    let _id : String
    let userId : String
    let unitId : String
    


}
