//
//  FindUnitsForAUser.swift
//  Events.au
//
//  Created by Akito Daiki on 09/07/2024.
//

import Foundation

class FindUnitsForAUser: APIManager {
    
    typealias ModelType = AllUnitsResponse
    var id: String
    
    init(id: String){
        self.id = id
    }
    
    var methodPath: String {
        return "/units/user/\(id)"
    }
}
