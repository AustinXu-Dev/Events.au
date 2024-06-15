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
    
    
    let organizer1 = OrganizerModel(_id: "6617a7a05da1ed206211d463", userId: "6612647ba01d8b97169ed9e4", eventId: "6617a7a05da1ed206211d461", status: "organizing")
    let organizer2 = OrganizerModel(_id: "66445cc00cf26de3af7ec476", userId: "661ff7eb38ad5b5348ac79b8", eventId: "66445cc00cf26de3af7ec474", status: "organizing")
    
}
