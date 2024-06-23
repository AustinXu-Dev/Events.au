//
//  KeychainManager.swift
//  Events.au
//
//  Created by Akito Daiki on 17/06/2024.
//

import Foundation
import KeychainSwift

class KeychainManager {
    
    static let shared = KeychainManager()
    
    let keychain = KeychainSwift()
    
    private init() {
        
    }
}
