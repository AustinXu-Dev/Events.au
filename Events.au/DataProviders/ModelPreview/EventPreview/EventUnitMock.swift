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
    
    let eventUnitA = EventUnitModel(_id: "661e3b32be3f0f96c295ee62", eventId: EventMock.instacne.eventA, unitId: UnitMock.instacne.unitA)
    
    
    let eventUnitB = EventUnitModel(_id: "661f820ddbe871a975363503", eventId: EventMock.instacne.eventB,unitId:UnitMock.instacne.unitB)
    
    
    let eventUnits = [
        EventUnitModel(_id: "661e3b32be3f0f96c295ee62", eventId: EventMock.instacne.eventA, unitId: UnitMock.instacne.unitA),
        EventUnitModel(_id: "661f820ddbe871a975363503", eventId: EventMock.instacne.eventB,unitId:UnitMock.instacne.unitB)
    ]
    
}

