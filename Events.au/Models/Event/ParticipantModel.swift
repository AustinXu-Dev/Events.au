//
//  ParticipantModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

//JSON Model

/*
 {
 userId*    {...}
 example: <mongoose _id>
 eventId*    {...}
 example: <mongoose _id>
 organzierId*    {...}
 example: <mongoose _id>
 status*    [...]
 email*    [...]
 phone*    [...]
 }
 */

//MARK: For getting one participant
struct ParticipantResponse : Codable {
    let success : Bool
    let message : ParticipantModel
}

//MARK: For getting all participants
struct AllParticipantsResponse : Codable {
    let success : Bool
    let message : [ParticipantModel]
}

struct ParticipantModel : Codable, Hashable {
    let _id : String?
    let userId : UserModel?
    let eventId : EventModel?
    let organzierId : OrganizerModel?
    let status, email : String?
    let phone : Int?
}

