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
 firstName*    string
 example: John
 First Name

 email*    string
 example: Doe
 Last Name

 fId*    string
 example: <firebase id>
 Firebase Id obtained from Google Auth

 unitId*    string
 example: <mongoose _id>
 Unit ID

 }
 */


struct SignUpResponse: Codable {
    let success: Bool
    let message: SignUpModel
}



struct SignUpModel: Codable {
    let user : UserModel
    
   
}
