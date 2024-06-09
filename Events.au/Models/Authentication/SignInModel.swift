//
//  UserModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model
/*
 {
 fId*    string
 example: <firebase id>
 Firebase Id obtained from Google Auth

 }
 */

struct SignInResponse: Codable {
    let success: Bool
    let message: SignInModel
}


struct SignInModel : Codable {
    let token : String
    let user: UserModel

}
