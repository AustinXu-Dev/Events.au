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

//MARK: request body for updating participant status for an event ( approval or rejection )

struct ParticipantApprovalDTO : Codable {
    let participantId : String
    let status : String
}

//MARK: request body for updating [all participants] status for an event ( approval or rejection )
struct AllParticipantsApprovalDTO : Codable {
    let participantIds : [String]
    let status : String
}
