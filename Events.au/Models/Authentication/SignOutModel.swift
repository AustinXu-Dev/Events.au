//
//  SignOutModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//Sign Out Model
/*
 {
 token*    string
 example: <jwt token>
 Token obtained from SignIn

 }
 */

struct SignOutResponse: Codable {
    let success: Bool
    let message: SignOutModel
}

struct SignOutModel  : Codable {
    let token : String
    //Token obtained from SignIn
}

