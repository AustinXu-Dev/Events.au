//
//  SignOutMock.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

struct SignOutDTOMock  {
    
    static let instacne = SignOutDTOMock()
    
    private init(){}
    
    let signOutDTO = SignOutDTO(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjQ5YmJiZGQ4MGRjYjA0ZjVjMjRkYyIsImlhdCI6MTcxNzk1MjUxOCwiZXhwIjoxNzE4MjExNzE4fQ.rM3BmO8DZZY6wfp-QS2hKxNZcM4Ghe50JDQZA7GJgD0")
    
}
