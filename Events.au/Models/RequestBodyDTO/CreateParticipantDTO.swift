//
//  CreateParticipantDTO.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//MARK: Use this as a body to approve a user to an event

struct CreateParticipantDTO {
    let userId : String
    let status : String
    let organizerId : String
}
