//
//  EventById.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 15/12/2024.
//

import Foundation

class GetEventById: APIManager {

  
  let eventId: String
  
  init(eventId: String) {
    self.eventId = eventId
  }
  
  typealias ModelType = EventResponse
  
  var methodPath: String {
    return "/event/\(eventId)"
  }
  
  
}

