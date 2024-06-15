//
//  SignUpDummyData.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

struct SignUpMock {
    
    static let instance = SignUpMock()
    
    private init(){}
    
    
    let signUpA = SignUpModel(user: UserModel(_id: "6612647ba01d8b97169ed9e4", fId: "sai1", firstName: "sai1", lastName: "pepu", email: "sai1@gmail.com", gender: "male", age: 22, phone: 0928282922, isAdmin: false))
    
    
    let signUpB = SignUpModel(user: UserModel(_id: "66649bbbdd80dcb04f5c24dc", fId: "9siSxLUVC6ZOPb5EPafTXV0m9c32", firstName: "Htet", lastName: "Aung Shine", email: "htetaungshine211299", gender: "male", age: 20, phone: 0929922922, isAdmin: false))
   
    
}

//unit ID


