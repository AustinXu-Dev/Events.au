//
//  AllUnitsByEventId.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 08/07/2024.
//

 
import Foundation
 
class AllUnitsByEventId : APIManager {
    typealias ModelType = EventUnitResponse

    let id : String
 
    init(id: String) {
        self.id = id
    }
    
    var methodPath: String {
        return "/units/event/\(id)"
    }
    
    
    
}
 
