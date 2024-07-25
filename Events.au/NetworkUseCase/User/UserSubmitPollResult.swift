//
//  UserSubmitPollResult.swift
//  Events.au
//
//  Created by Austin Xu on 2024/7/24.
//

import Foundation

class UserSubmitPollResult: APIManager{
    typealias ModelType = PollResultDTO
    
    var methodPath: String{
        return "/user/poll/result"
    }
    
    
}
