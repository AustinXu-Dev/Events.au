//
//  ParticipantMock.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

struct ParticipantMock  {
    
    static let instacne = ParticipantMock()
    
    private init(){}
    
    
    let participantA = ParticipantModel(_id: "661eb2f90ee1d9755719ad0d", userId: "661eb1d1002159f49f4e3558", eventId: "6617a7a05da1ed206211d461", organzierId: "6617a7a05da1ed206211d463", status: "pending", email: "sai2@gmail.com", phone: 09199292232)
    
    let participantB = ParticipantModel(_id: "664455d8168e2d6ca4eb8101", userId: "661ff7eb38ad5b5348ac79b8", eventId: "6617a7a05da1ed206211d461", organzierId: "661ab7d4a5681aae60b9599d", status: "pending", email: "admin7@gmail.com", phone: 0928999292)
    
    let participants = [
        ParticipantModel(_id: "661eb2f90ee1d9755719ad0d", userId: "661eb1d1002159f49f4e3558", eventId: "6617a7a05da1ed206211d461", organzierId: "6617a7a05da1ed206211d463", status: "pending", email: "sai2@gmail.com", phone: 09199292232),
        ParticipantModel(_id: "664455d8168e2d6ca4eb8101", userId: "661ff7eb38ad5b5348ac79b8", eventId: "6617a7a05da1ed206211d461", organzierId: "661ab7d4a5681aae60b9599d", status: "pending", email: "admin7@gmail.com", phone: 0928999292),
        ParticipantModel(_id: "661eb2f90ee1d9755719ad0d", userId: "661eb1d1002159f49f4e3558", eventId: "6617a7a05da1ed206211d461", organzierId: "6617a7a05da1ed206211d463", status: "pending", email: "sai2@gmail.com", phone: 09199292232),
        ParticipantModel(_id: "664455d8168e2d6ca4eb8101", userId: "661ff7eb38ad5b5348ac79b8", eventId: "6617a7a05da1ed206211d461", organzierId: "661ab7d4a5681aae60b9599d", status: "pending", email: "admin7@gmail.com", phone: 0928999292),
        ParticipantModel(_id: "661eb2f90ee1d9755719ad0d", userId: "661eb1d1002159f49f4e3558", eventId: "6617a7a05da1ed206211d461", organzierId: "6617a7a05da1ed206211d463", status: "pending", email: "sai2@gmail.com", phone: 09199292232),
        ParticipantModel(_id: "664455d8168e2d6ca4eb8101", userId: "661ff7eb38ad5b5348ac79b8", eventId: "6617a7a05da1ed206211d461", organzierId: "661ab7d4a5681aae60b9599d", status: "pending", email: "admin7@gmail.com", phone: 0928999292),
        ParticipantModel(_id: "661eb2f90ee1d9755719ad0d", userId: "661eb1d1002159f49f4e3558", eventId: "6617a7a05da1ed206211d461", organzierId: "6617a7a05da1ed206211d463", status: "pending", email: "sai2@gmail.com", phone: 09199292232),
        ParticipantModel(_id: "664455d8168e2d6ca4eb8101", userId: "661ff7eb38ad5b5348ac79b8", eventId: "6617a7a05da1ed206211d461", organzierId: "661ab7d4a5681aae60b9599d", status: "pending", email: "admin7@gmail.com", phone: 0928999292)
        
    ]
    
}
