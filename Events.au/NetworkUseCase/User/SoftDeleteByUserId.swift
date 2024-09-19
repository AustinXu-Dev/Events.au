//
//  SoftDeleteByUserId.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 20/09/2024.
//

import Foundation

class SoftDeleteByUserId : APIManager {

    var id: String
    
    init(id: String){
        self.id = id
    }
    
    typealias ModelType = UserDeleteDTO
    
    var methodPath: String {
       return "/user/\(id)/soft-delete"
    }
    
}
