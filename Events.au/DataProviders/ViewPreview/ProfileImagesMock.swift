//
//  ProfileImagesMock.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 14/06/2024.
//

import Foundation

struct ProfileImagesMock  {
    
    static let instance = ProfileImagesMock()
    private init() {}
    
    let images : [ProfileImageModel] = [
        ProfileImageModel(id: 1, name: "PersonA"),
        ProfileImageModel(id: 2, name: "PersonB"),
        ProfileImageModel(id: 3, name: "PersonA"),
        ProfileImageModel(id: 4, name: "PersonB"),
        ProfileImageModel(id: 5, name: "PersonA"),
        ProfileImageModel(id: 6, name: "PersonB"),
        ProfileImageModel(id: 7, name: "PersonA"),
        ProfileImageModel(id: 8, name: "PersonB")
    ]
}

struct ProfileImageModel : Identifiable {
    let id : Int
    let name : String
}
