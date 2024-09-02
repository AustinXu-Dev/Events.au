//
//  AllUnits.swift
//  Events.au
//
//  Created by Akito Daiki on 19/06/2024.
//

import Foundation

class AllUnits: APIManager {
    typealias ModelType = AllUnitsResponse
    var methodPath: String {
        return "/units"
    }
}
