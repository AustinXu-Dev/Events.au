//
//  GetPollsByEventId.swift
//  Events.au
//
//  Created by Austin Xu on 2024/7/24.
//

import Foundation

class GetPollsByEventId: APIManager{
    let id : String
    init(id: String) {
        self.id = id
    }
    typealias ModelType = PollsResponse
    
    var methodPath: String{
        return "/poll/event/\(id)"
    }
}
