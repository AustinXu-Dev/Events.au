//
//  SignInModel.swift
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

 firstName*    string
 example: John
 First Name

 lastName*    string
 example: Doe
 Last Name

 email*    string
 example: JohnDoe@gmail.com
 Email Address

 gender*    string
 example: male
 Gender

 age*    number
 example: 25
 Age

 phone*    number
 example: 1234567890
 Phone Number

 isAdmin*    boolean
 example: false
 Is Admin Boolean Value

 }
 */

//MARK: For Getting A User
struct UserResponse : Codable {
    let success: Bool
    let message: UserModel
}

//MARK: For Getting All Users
struct AllUsersResponse : Codable {
    let success: Bool
    let message: [UserModel]
}

struct UserModel: Codable {
    let _id,fId, firstName,lastName,email,gender : String
    let age, phone : Int
    let isAdmin : Bool
}
