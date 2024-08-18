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
    
    let participantA = ParticipantModel(_id: "661eb2f90ee1d9755719ad0d", userId: UserMock.instance.user3, eventId: EventMock.instacne.eventA, organzierId: OrganizerMock.instance.organizer1, status: "pending", email: "sai2@gmail.com", phone: 09199292232)
   
    let participantB = ParticipantModel(_id: "664455d8168e2d6ca4eb8101", userId: UserMock.instance.user3, eventId: EventMock.instacne.eventB, organzierId: OrganizerMock.instance.organizer2, status: "approved", email: "admin7@gmail.com", phone: 0928999292)
    
 
    
    let participants = [
        ParticipantModel(_id: "664455d8168e2d6ca4eb8101", userId: UserMock.instance.user3, eventId: EventMock.instacne.eventB, organzierId: OrganizerMock.instance.organizer2, status: "approved", email: "admin7@gmail.com", phone: 0928999292),
        ParticipantModel(_id: "661eb2f90ee1d9755719ad0d", userId: UserMock.instance.user3, eventId: EventMock.instacne.eventA, organzierId: OrganizerMock.instance.organizer1, status: "pending", email: "sai2@gmail.com", phone: 09199292232),
        ParticipantModel(_id: "664455d8168e2d6ca4eb8101", userId: UserMock.instance.user3, eventId: EventMock.instacne.eventB, organzierId: OrganizerMock.instance.organizer2, status: "approved", email: "admin7@gmail.com", phone: 0928999292),
        ParticipantModel(_id: "661eb2f90ee1d9755719ad0d", userId: UserMock.instance.user3, eventId: EventMock.instacne.eventA, organzierId: OrganizerMock.instance.organizer1, status: "pending", email: "sai2@gmail.com", phone: 09199292232)
//        ParticipantModel(_id: "661eb2f90ee1d9755719ad0d", userId: UserMock.instance.user1, eventId: EventMock.instacne.eventA, status: "pending", email: "sai2@gmail.com", phone: 09199292232),
//        ParticipantModel(_id: "664455d8168e2d6ca4eb8101", userId: UserMock.instance.user2, eventId: EventMock.instacne.eventB, status: "approved", email: "admin7@gmail.com", phone: 0928999292),
//        ParticipantModel(_id: "661eb2f90ee1d9755719ad0d", userId: UserMock.instance.user1, eventId: EventMock.instacne.eventA, status: "pending", email: "sai2@gmail.com", phone: 09199292232),
//        ParticipantModel(_id: "664455d8168e2d6ca4eb8101", userId: UserMock.instance.user2, eventId: EventMock.instacne.eventB, status: "approved", email: "admin7@gmail.com", phone: 0928999292),
    ]
    
    
    let participantVM = GetParticipantsByEventIdViewModel()
    
    
}
