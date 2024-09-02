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


struct BackendSchema : Codable {
    let success : Bool
    let message : ParticipantModel
}

struct ParticipantModel :  Identifiable, Codable, Hashable {
    
    let _id : String?
    var id: String? { _id ?? "" }
    let userId : UserModel2?
    let eventId : EventModel?
    let organzierId : OrganizerModel?
    let status : String?
    let email : String?
    let phone : Int?
    
    enum CodingKeys : String,CodingKey {
        case _id = "_id"
        case userId = "userId"
        case eventId = "eventId"
        case organzierId = "organzierId"
        case status = "status"
        case email = "email"
        case phone = "phone"
    }
    
}
/*
"success": true,
"message": [
  {
    "success": true,
    "message": {
      "_id": "66bb12eab133a260ae6509f8",
      "userId": {
        "_id": "66bb129ae70b72a2274116a2",
        "fId": "LuqyShjl2mUy5fRUzEWxKXSjUQ03",
        "firstName": "Si Si",
        "email": "tetrabyte.contact@gmail.com",
        "phone": 6969696,
        "createdAt": "2024-08-13T08:00:26.333Z",
        "updatedAt": "2024-08-13T08:00:26.333Z",
        "__v": 0
      },
      "eventId": {
        "_id": "66b32f3a17e53d786cbebd36",
        "name": "Lee event",
        "description": "Don't be gay.",
        "startDate": "07-08-2024",
        "endDate": "08-08-2024",
        "startTime": "12:00",
        "endTime": "04:00",
        "location": "",
        "rules": "",
        "coverImageUrl": "",
        "status": "approved",
        "createdAt": "2024-08-07T08:24:26.789Z",
        "updatedAt": "2024-08-20T12:04:24.671Z",
        "__v": 0,
        "adminId": "66bba484bda8c4082b4f9f0e"
      },
      "status": "pending",
      "createdAt": "2024-08-13T08:01:46.974Z",
      "updatedAt": "2024-08-13T08:01:46.974Z",
      "__v": 0
    }
  },
*/


struct ResultResponse : Codable, Hashable {
    let result : [ResultModel]?
}


struct ResultModel : Codable, Hashable {
    let optionId : String?
    let answer : Bool?
    let _id : String?
}



