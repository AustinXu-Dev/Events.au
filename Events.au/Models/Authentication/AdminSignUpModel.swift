//
//  AdminSignUpModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 22/06/2024.
//

import Foundation

//MARK: use this as a response model for admin sign up
struct AdminSignUpResponse: Codable {
    let success: Bool
    let message: AdminSignUpModel
}

struct AdminSignUpModel: Codable {
    let user : UserModel
    let admin : AdminModel
}
