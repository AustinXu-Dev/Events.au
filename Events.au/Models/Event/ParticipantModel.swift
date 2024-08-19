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

struct ParticipantModel : Identifiable, Codable, Hashable {
    
    let _id : String?
    var id: String { _id ?? "" }
    let userId : UserModel2?
    let eventId : EventModel?
    let organzierId : OrganizerModel?
    let status, email : String?
    let phone : Int?
    
    enum CodingKeys : String,CodingKey {
        case _id = "id"
        case userId = "userId"
        case eventId = "eventId"
        case organzierId = "organzierId"
        case status = "status"
        case email = "email"
        case phone = "phone"
    }
}


struct ResultResponse : Codable, Hashable {
    let result : [ResultModel]?
}


struct ResultModel : Codable, Hashable {
    let optionId : String?
    let answer : Bool?
    let _id : String?
}



