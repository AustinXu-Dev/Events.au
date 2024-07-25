//
//  PollModel.swift
//  Events.au
//
//  Created by Austin Xu on 2024/7/24.
//

import Foundation

struct PollsResponse: Codable{
    let success: Bool
    let message: [PollModel]
}

struct PollModel: Codable{
    let _id, eventId, title : String
    let multi_select: Bool
    let options: [OptionModel]
}

struct OptionModel: Codable{
    let title: String
    let isTextField: Bool
    let _id: String
}
