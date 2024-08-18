//
//  ParticipantByUserId.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 18/08/2024.
//

import Foundation

class GetParticipantByUserId : APIManager {
    let id : String
    init(id: String) {
        self.id = id
    }
    
    typealias ModelType = AllParticipantsResponse
    
    var methodPath: String {
        return "/participants?userId=\(id)"
    }
    
}

//https://events-au-v2.vercel.app/participants?userId=669fa2f07057a4b70d209d1f
