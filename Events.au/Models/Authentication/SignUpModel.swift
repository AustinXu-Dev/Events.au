//
//  SignUpModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
 {
   "success": true,
   "message": {
     "user": {
       "fId": "<firebase id>",
       "firstName": "Updated",
       "lastName": "Doe",
       "email": "JohnDoe@gmail.com",
       "gender": "male",
       "age": 25,
       "phone": 1234567890,
       "isAdmin": false
     }
   }
 }
 */

struct SignUpResponse: Codable {
    let success: Bool
    let message: SignUpModel
}

struct SignUpModel: Codable {
    let user : UserModel
}
