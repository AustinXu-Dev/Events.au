//
//  CategoryValue.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 17/06/2024.
//

import Foundation

struct CategoryValueModel : Identifiable {
    let id = UUID().uuidString
    let image : String
    let name : String
}


struct CategoryValue {
    static let categories : [CategoryValueModel] = [
        CategoryValueModel(image: Theme.academyIcon, name: "Academic"),
        CategoryValueModel(image: Theme.entertainmentIcon , name: "Entertainment"),
        CategoryValueModel(image: Theme.techIcon , name: "Technology"),
        CategoryValueModel(image: Theme.businessIcon , name: "Business"),
        CategoryValueModel(image: Theme.gamingIcon, name: "Gaming")
    ]
}
