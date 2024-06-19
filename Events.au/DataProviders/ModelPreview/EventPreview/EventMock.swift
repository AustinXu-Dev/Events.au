//
//  EventMock.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation


struct EventMock  {
    
    static let instacne = EventMock()
    
    private init(){}
    
    
    let eventA = EventModel(_id: "6617a7a05da1ed206211d461", name: "update testing basic info", description: "This event is a testing event. We will be doing numerous activities in this event. So, please feel free to join.", startDate: Date().formattedDate(), endDate: Date().formattedDate(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "ABAC Bangna", rules: "Please wear the dress code as in the booklet.", coverImageUrL: "https://picsum.photos/1200", adminId: "6646e25dd02d2dbdd7bb19cd", status: "rejected")
    
    let eventB = EventModel(_id: "661ab7d4a5681aae60b9599b", name: "event 1 edited", description: "This event is a testing event. We will be doing numerous activities in this event. So, please feel free to join.", startDate: Date().formattedDate(), endDate: Date().formattedDate(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "ABAC Home Sweet Home", rules: "Dudes from the hood are not permitted.", coverImageUrL: "https://picsum.photos/1200", adminId: "661ff7eb38ad5b5348ac79ba", status: "active")
    
    let eventC = EventModel(_id: "661e37914f6d3a8be1b8784d", name: "event testing 16", description: "This event is a testing event. We will be doing numerous activities in this event. So, please feel free to join.", startDate: Date().formattedDate(), endDate: Date().formattedDate(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "ABAC Mucho", rules: "Please don't bring kids under 18.", coverImageUrL: "https://picsum.photos/1200", adminId: "661ff7eb38ad5b5348ac79ba", status: "pending")
    
    let eventD = EventModel(_id: "66445cc00cf26de3af7ec474", name: "Event Name", description: "This event is a testing event. We will be doing numerous activities in this event. So, please feel free to join.", startDate: Date().formattedDate(), endDate: Date().formattedDate(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "Shwe Pyi Thar", rules: "Suka Blyat", coverImageUrL: "https://picsum.photos/1200", adminId: "661ff7eb38ad5b5348ac79ba", status: "active")
    
    
    let allEvents : [EventModel] = [
        EventModel(_id: "6617a7a05da1ed206211d461", name: "update testing basic info", description: "This event is a testing event. We will be doing numerous activities in this event. So, please feel free to join.", startDate: Date().formattedDate(), endDate: Date().formattedDate(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "ABAC Bangna", rules: "Please wear the dress code as in the booklet.", coverImageUrL: "https://picsum.photos/1200", adminId: "6646e25dd02d2dbdd7bb19cd", status: "approved"),
        EventModel(_id: "661e37914f6d3a8be1b8784d", name: "event testing 16", description: "This event is a testing event. We will be doing numerous activities in this event. So, please feel free to join.", startDate: Date().formattedDate(), endDate: Date().formattedDate(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "ABAC Mucho", rules: "Please don't bring kids under 18.", coverImageUrL: "https://picsum.photos/1200", adminId: "661ff7eb38ad5b5348ac79ba", status: "pending"),
        EventModel(_id: "661e37914f6d3a8be1b8784d", name: "event testing 16", description: "This event is a testing event. We will be doing numerous activities in this event. So, please feel free to join.", startDate: Date().formattedDate(), endDate: Date().formattedDate(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "ABAC Mucho", rules: "Please don't bring kids under 18.", coverImageUrL: "https://picsum.photos/1200", adminId: "661ff7eb38ad5b5348ac79ba", status: "pending"),
        EventModel(_id: "66445cc00cf26de3af7ec474", name: "Event Name", description: "This event is a testing event. We will be doing numerous activities in this event. So, please feel free to join.", startDate: Date().formattedDate(), endDate: Date().formattedDate(), startTime: Date().formattedTime(), endTime: Date().formattedTime(), location: "Shwe Pyi Thar", rules: "Suka Blyat", coverImageUrL: "https://picsum.photos/1200", adminId: "661ff7eb38ad5b5348ac79ba", status: "active")
    
    ]
    
    
}
