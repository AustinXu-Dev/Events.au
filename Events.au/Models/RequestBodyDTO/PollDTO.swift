//
//  PollDTO.swift
//  Events.au
//
//  Created by Austin Xu on 2024/7/23.
//

import Foundation
import Combine

class PollDTO: ObservableObject, Identifiable, Equatable, Codable {
    static func == (lhs: PollDTO, rhs: PollDTO) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.multi_select == rhs.multi_select &&
        lhs.options == rhs.options
    }
    
    var id: UUID = UUID()
    var eventId: String
    @Published var title: String
    @Published var multi_select: Bool
    @Published var options: [OptionDTO]
    
    // CodingKeys to conform to Codable protocol
    enum CodingKeys: String, CodingKey {
        case id
        case eventId
        case title
        case multi_select
        case options
    }
    
    init(eventId: String = "",title: String = "", multi_select: Bool = false, options: [OptionDTO] = []) {
        self.eventId = eventId
        self.title = title
        self.multi_select = multi_select
        self.options = options
    }
    
    // Decodable init
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        eventId = try container.decode(String.self, forKey: .eventId)
        title = try container.decode(String.self, forKey: .title)
        multi_select = try container.decode(Bool.self, forKey: .multi_select)
        options = try container.decode([OptionDTO].self, forKey: .options)
    }
    
    // Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(eventId, forKey: .eventId)
        try container.encode(title, forKey: .title)
        try container.encode(multi_select, forKey: .multi_select)
        try container.encode(options, forKey: .options)
    }
}


class OptionDTO: Codable, ObservableObject, Equatable {
    static func == (lhs: OptionDTO, rhs: OptionDTO) -> Bool {
        return lhs.title == rhs.title && lhs.isTextField == rhs.isTextField
    }
    
    @Published var title: String
    @Published var isTextField: Bool
    
    init(title: String = "", isTextField: Bool = false) {
        self.title = title
        self.isTextField = isTextField
    }
    
    // CodingKeys to conform to Codable protocol
    enum CodingKeys: String, CodingKey {
        case title
        case isTextField
    }
    
    // Decodable init
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        isTextField = try container.decode(Bool.self, forKey: .isTextField)
    }
    
    // Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(isTextField, forKey: .isTextField)
    }
}


struct PollDTOFinal: Codable{
    let eventId: String
    let title: String
    let multi_select: Bool
    let options: [OptionDTO]
}
