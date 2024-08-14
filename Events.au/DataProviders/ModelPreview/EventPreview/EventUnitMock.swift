//
//  EventUnitMock.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

struct EventUnitMock  {
    
    static let instacne = EventUnitMock()
    
    private init(){}
    
    let eventUnitA = EventUnitModel(_id: "661e3b32be3f0f96c295ee62", eventId: EventModel(_id: "661e3b32be3f0f96c295ee5c", name: "event testing 15:47", description: "This event is Events.AU pilot launching event.", startDate: Date().formattedDateAndMonth(), endDate: Date().formattedDateAndMonth(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "ABAC", rules: "There is no rules", coverImageUrl:  "https://picsum.photos/1200", adminId: "661ff7eb38ad5b5348ac79ba", status: "approved"), unitId: UnitModel(id: "661e1d459d67f48368bafbb6", name: "unit 1", description: "testing unit create route"))
    
    
    let eventUnitB = EventUnitModel(_id: "661f820ddbe871a975363503", eventId: EventModel(_id: "6617a7a05da1ed206211d461", name: "update testing basic info", description: "No description", startDate: Date().formattedDateAndMonth(), endDate: Date().formattedDateAndMonth(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "ABAC", rules: "There will be no ground rules.", coverImageUrl:  "https://picsum.photos/1200", adminId: "6646e25dd02d2dbdd7bb19cd", status: "rejected"), unitId: UnitModel(id: "661e96e1c6ca7a788be0025e", name: "unit 2", description: "Testing data for description"))
    
    
    let eventUnits = [
        EventUnitModel(_id: "661e3b32be3f0f96c295ee62", eventId: EventModel(_id: "661e3b32be3f0f96c295ee5c", name: "event testing 15:47", description: "This event is Events.AU pilot launching event.", startDate: Date().formattedDateAndMonth(), endDate: Date().formattedDateAndMonth(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "ABAC", rules: "There is no rules", coverImageUrl:  "https://picsum.photos/1200", adminId: "661ff7eb38ad5b5348ac79ba", status: "approved"), unitId: UnitModel(id: "661e1d459d67f48368bafbb6", name: "unit 1", description: "testing unit create route")),
        EventUnitModel(_id: "661f820ddbe871a975363503", eventId: EventModel(_id: "6617a7a05da1ed206211d461", name: "update testing basic info", description: "No description", startDate: Date().formattedDateAndMonth(), endDate: Date().formattedDateAndMonth(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "ABAC", rules: "There will be no ground rules.", coverImageUrl:  "https://picsum.photos/1200", adminId: "6646e25dd02d2dbdd7bb19cd", status: "rejected"), unitId: UnitModel(id: "661e96e1c6ca7a788be0025e", name: "unit 2", description: "Testing data for description"))
    ]
    
}

