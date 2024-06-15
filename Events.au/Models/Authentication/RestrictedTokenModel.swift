//
//  TokenModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
 {
 token*    string
 example: <jwt token>
 Token obtained from SignOut

 }
 */

struct RestrictedTokenResponse : Codable {
    let success : Bool
    let message : String
}

struct RestrictedTokenModel : Codable {
    let token : String
}
