//
//  OrganizerDummyData.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

struct OrganizerMock {
    
    static let instance = OrganizerMock()
    
    private init(){}
    
    let organizer1 = OrganizerModel(_id: "6617a7a05da1ed206211d463", userId: UserMock.instance.user1, eventId: EventMock.instacne.eventA, status: "organizing")
    
    let organizer2 = OrganizerModel(_id: "66445cc00cf26de3af7ec476",userId: UserMock.instance.user2,eventId: EventMock.instacne.eventB,status: "pending")
    
}
