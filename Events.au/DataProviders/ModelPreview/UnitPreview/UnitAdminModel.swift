//
//  UnitAdminModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

struct UnitAdminMock  {
    
    static let instacne = UnitAdminMock()
    
    private init(){}
    
    let unitAdminA = UnitAdminModel(_id: "661ff7eb38ad5b5348ac79bc", adminId: AdminModel(_id: "661ff7eb38ad5b5348ac79ba", userId: "661ff7eb38ad5b5348ac79b8", unitId: "661e1d459d67f48368bafbb6"), unitId: UnitModel(_id: "661e1d459d67f48368bafbb6", name: "unit 1", description: "testing unit create route"))
    let unitAdminB = UnitAdminModel(_id: "6646e1d0d02d2dbdd7bb19bb", adminId: AdminModel(_id: "6646e1d0d02d2dbdd7bb19b9", userId: "6646e1d0d02d2dbdd7bb19b7", unitId: "661e1d459d67f48368bafbb6"), unitId: UnitModel(_id: "661e1d459d67f48368bafbb6", name: "unit 1", description: "testing unit create route"))

    
    
}
