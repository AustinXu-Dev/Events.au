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
    
    
    
    let signInA = SignInModel(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjRiYWIyYWZlNTk5NDJmOTI0NTA4NSIsImlhdCI6MTcxNzg4MjIzOSwiZXhwIjoxNzE4MTQxNDM5fQ.JjtTNSEM5y717jKCfx9mjraouT9A_vpUZ1rppJBipyA", user: "6664bab2afe59942f9245085")
    let signInB = SignInModel(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ5YmJiZGQ4MGRjYjA0ZjVjMjRkYyIsImlhdCI6MTcxNzg4MjM1OCwiZXhwIjoxNzE4MTQxNTU4fQ.V_v3UKyilG9fUzFbsZuo1eD8PEbarK8kBi_rPN4agnM", user: "66649bbbdd80dcb04f5c24dc")

    
}
