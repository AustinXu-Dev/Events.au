//
//  SignUpDTOModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation
//JSON
/*
 {
   "firstName": "John",
   "email": "Doe",
   "phone": 123456788,
   "fId": "<firebase id>",
   "unitId": "<mongoose _id>"
 }
 */

//MARK: Use this as a body for sign up request
struct SignUpDTO : Codable {
    let firstName,email : String
    let phone : Int
    let fId,unitId : String
}

