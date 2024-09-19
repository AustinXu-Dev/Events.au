//
//  UnitMock.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

struct UnitMock  {
    
    static let instacne = UnitMock()
    
    private init(){}
    
    let unitA = UnitModel(id: "661e1d459d67f48368bafbb6", name: "DCode", description: "testing unit create route")
    let unitB = UnitModel(id: "661e96e1c6ca7a788be0025e", name: "unit 2", description: "testing unit create route")
let units = [
    UnitModel(id: "661e1d459d67f48368bafbb6", name: "DCode", description: "testing unit create route"),
    UnitModel(id: "661e96e1c6ca7a788be0025e", name: "unit 2", description: "testing unit create route")
]
    
}
