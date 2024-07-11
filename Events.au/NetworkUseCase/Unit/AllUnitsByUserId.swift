//
//  UnitByUserId.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 11/07/2024.
//

import Foundation
//https://events-au-v2.vercel.app/units/user/666d48609ad6b85eeaea33ac

class AllUnitsByUserId : APIManager {
    let id : String
    
    init(id: String) {
        self.id = id
    }
    
    typealias ModelType = AllUnitsResponse
    var methodPath: String {
        return "/units/user/\(id)"
    }
 
}
