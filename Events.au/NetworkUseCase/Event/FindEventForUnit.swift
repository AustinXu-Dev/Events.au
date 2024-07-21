//
//  FindEventForUnit.swift
//  Events.au
//
//  Created by Akito Daiki on 09/07/2024.
//

import Foundation

class FindEventForUnit: APIManager {
    
    typealias ModelType = EventUnitResponse
    var id: String
    
    init(id: String){
        self.id = id
    }
    
    var methodPath: String {
        return "/events/unit/\(id)"
    }
}
