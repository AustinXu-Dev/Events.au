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


struct ParticipantResponseModel : Codable {
    let success : Bool
    let message : ParticipantModel
}


struct ParticipantModel : Codable {
    let _id,userId, eventId, organzierId,status, email : String
    let phone : Int
    

    
    
    
}
