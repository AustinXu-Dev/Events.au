//
//  UpdateParticipantStatusModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation


// JSON Model
/*
 {
 participants*    [
 example: List [ "<mongoose _id>" ]
 The ID List of the participants

 string]
 status*    string
 example: accepted | rejected | kicked
 One of the Status.

 }
 */

struct UpdateParticipantStatusResponse: Codable {
    let success: Bool
    let message: UpdateParticipantStatusModel
}



struct UpdateParticipantStatusModel : Codable {
    let participants : [String]
    let status : String
    
    
    
}

