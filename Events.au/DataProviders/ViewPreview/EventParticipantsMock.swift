//
//  EventParticipantsMock.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 15/06/2024.
//

import Foundation

struct EventParticipantsMock {
    static let instance = EventParticipantsMock()
    private init() {}
    
    let approvedParticipants : [EventParticipantMockModel] = [
        EventParticipantMockModel(image:"PersonA",name:"Blyat",unit:"VMES"),
        EventParticipantMockModel(image:"PersonB",name:"Suka Bizness Suka",unit:"VMES")

    ]
    
    let pendingParticipants : [EventParticipantMockModel] = [
        EventParticipantMockModel(image:"PersonA",name:"Karina",unit:"VMES"),
        EventParticipantMockModel(image:"PersonA",name:"Suka",unit:"VMES")
    
    ]
    
    let profile : EventParticipantMockModel = EventParticipantMockModel(image:"PersonA",name:"Suka Binezz Suka",unit:"VMES")
}

struct EventParticipantMockModel : Identifiable, Equatable{
    let id = UUID().uuidString
    let image : String
    let name : String
    let unit : String
}


