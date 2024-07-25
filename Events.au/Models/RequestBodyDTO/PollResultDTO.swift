//
//  PollResultDTO.swift
//  Events.au
//
//  Created by Austin Xu on 2024/7/24.
//

import Foundation

struct PollResultDTO: Codable{
    let userId: String
    let pollId: String
    let result: [OptionAnswerModel]
}

struct OptionAnswerModel: Codable{
    let optionId: String
    let answer: Bool
}
