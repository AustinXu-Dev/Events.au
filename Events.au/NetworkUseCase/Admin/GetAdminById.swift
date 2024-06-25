//
//  GetAdminById.swift
//  Events.au
//
//  Created by Akito Daiki on 24/06/2024.
//

import Foundation

class GetAdminById: APIManager {
    
    typealias ModelType = AdminResponse
    var id: String
    
    init(id: String){
        self.id = id
    }
    
    var methodPath: String {
        return "/admin/\(id)"
    }
}
