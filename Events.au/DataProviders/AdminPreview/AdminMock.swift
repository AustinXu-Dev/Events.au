//
//  AdminMock.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation


struct AdminMock  {
    
    static let instacne = AdminMock()
    
    private init(){}
    
    let adminA = AdminModel(_id: "661ff7eb38ad5b5348ac79ba", userId: "661ff7eb38ad5b5348ac79b8", unitId: "661e1d459d67f48368bafbb6")
    let adminB = AdminModel(_id: "6646e1d0d02d2dbdd7bb19b9", userId: "6646e1d0d02d2dbdd7bb19b7", unitId: "661e1d459d67f48368bafbb6")
    
}
