//
//  AllEventsMock.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 16/06/2024.
//

import Foundation

struct AllEventsMock {
    
    static let oneEvent : EventModel =   EventModel(_id: "1", name: "Dcode Event", description: "This event is the first ever event from dcode labs", startDate: "5th June", endDate: "7th June", startTime: "18:00", endTime: "20:00", location: "True Labs", rules: "No mushroom", coverImageUrl: EventImageMock.image, status: "Pending", adminId: "")
    
    static let events : [EventModel] = [
        EventModel(_id: "1", name: "Dcode Event", description: "This event is the first ever event from dcode labs", startDate: "5th June", endDate: "7th June", startTime: "18:00", endTime: "20:00", location: "True Labs", rules: "No mushroom", coverImageUrl: EventImageMock.image, status: "Pending", adminId: ""),
        EventModel(_id: "1", name: "Dcode Event", description: "This event is the first ever event from dcode labs", startDate: "5th June", endDate: "7th June", startTime: "18:00", endTime: "20:00", location: "True Labs", rules: "No mushroom", coverImageUrl: EventImageMock.image, status: "Pending", adminId: ""),
        EventModel(_id: "1", name: "Dcode Event", description: "This event is the first ever event from dcode labs", startDate: "5th June", endDate: "7th June", startTime: "18:00", endTime: "20:00", location: "True Labs", rules: "No mushroom", coverImageUrl: EventImageMock.image, status: "Pending", adminId: ""),
        EventModel(_id: "1", name: "Dcode Event", description: "This event is the first ever event from dcode labs", startDate: "5th June", endDate: "7th June", startTime: "18:00", endTime: "20:00", location: "True Labs", rules: "No mushroom", coverImageUrl: EventImageMock.image, status: "Pending", adminId: ""),
        EventModel(_id: "1", name: "Dcode Event", description: "This event is the first ever event from dcode labs", startDate: "5th June", endDate: "7th June", startTime: "18:00", endTime: "20:00", location: "True Labs", rules: "No mushroom", coverImageUrl: EventImageMock.image, status: "Pending", adminId: ""),
        EventModel(_id: "1", name: "Dcode Event", description: "This event is the first ever event from dcode labs", startDate: "5th June", endDate: "7th June", startTime: "18:00", endTime: "20:00", location: "True Labs", rules: "No mushroom", coverImageUrl: EventImageMock.image, status: "Pending", adminId: "")
    
    ]
    
}




struct AllEventsMockModel : Identifiable {
    
    let id = UUID().uuidString
    let name : String
}
