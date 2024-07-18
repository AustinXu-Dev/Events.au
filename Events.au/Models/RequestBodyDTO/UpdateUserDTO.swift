//
//  UpdateUserDTO.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 22/06/2024.
//

import Foundation

//MARK: request body for updating a user info
struct UpdateUserDTO : Codable {
    let firstName,lastName, email : String
}

