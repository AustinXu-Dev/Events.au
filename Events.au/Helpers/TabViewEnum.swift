//
//  TabViewEnum.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import Foundation

enum Tab {
    case home, remarks, profile
}

enum HomeNavigation: Hashable{
    // Dummy enum for testing
    case child, secondChild(Person)
}

enum RemarkNavigation: Hashable{
    case remark1, remark2
}

enum ProfileNavigation: Hashable{
    case profile, setting
}


struct Person: Hashable{
    let name: String
    let lastName: String
}
