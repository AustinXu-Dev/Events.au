//
//  SignInDummyData.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation


struct SignInMock {
    static let instance = SignInMock()
    
    private init(){}
    
    let signInA = SignInModel(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ5YmJiZGQ4MGRjYjA0ZjVjMjRkYyIsImlhdCI6MTcxNzkyMDk2MywiZXhwIjoxNzE4MTgwMTYzfQ.pQTV90Boghl50aSq6W4Q6JiXsDHMJnahm0k1ZL2xQPU", user: UserModel(_id: "66649bbbdd80dcb04f5c24dc", fId: "9siSxLUVC6ZOPb5EPafTXV0m9c32", firstName: "htet", lastName: "Aung Shine", email: "htetaungshine211299@gmail.com", gender: "male", age: 23, phone: 092920222, isAdmin: false))
    let signInB = SignInModel(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MTI2NDdiYTAxZDhiOTcxNjllZDllNCIsImlhdCI6MTcxNzkyMTA0MSwiZXhwIjoxNzE4MTgwMjQxfQ.xvLjJ9u1mItdAxpJULnNGxr1RGzxDMd9MlCQXvhtVk0", user: UserModel(_id: "6612647ba01d8b97169ed9e4", fId: "sai1", firstName: "sai1", lastName: "pepu", email: "sai1@gmail.com", gender: "male", age: 22, phone: 0928282922, isAdmin: false))
    
  
    
}
