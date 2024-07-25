//
//  UserDummyData.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation


struct UserMock {
    
    static let instance = UserMock()
    
    private init(){}
    
    
    let user1 = UserModel(_id: "66649bbbdd80dcb04f5c24dc", fId: "9siSxLUVC6ZOPb5EPafTXV0m9c32", firstName: "Htet", lastName: "Aung Shine", email: "htetaungshine211299@gmail.com", gender: "male", age: 24, phone: 09292922, isAdmin: false)
    let user2 = UserModel(_id: "6664bab2afe59942f9245085", fId: "pxnSOL4uMjePjlwutA7yZdTROGw2", firstName: "Swan", lastName: "Aung", email: "swannayphueaung0182@gmail.com", gender: "Male", age: 21, phone: 098288222, isAdmin: false)
    
    
    let user3 = UserModel2(_id: "66649bbbdd80dcb04f5c24dc", fId: "9siSxLUVC6ZOPb5EPafTXV0m9c32", firstName: "Swan", email: "nigga@gmail.com", phone: 092920022, isOrganizer: false)
    
}
