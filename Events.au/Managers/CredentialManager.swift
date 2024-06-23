//
//  CredentialManager.swift
//  Events.au
//
//  Created by Akito Daiki on 22/06/2024.
//

import Foundation

class CredentialManager {
    
    static let shared = CredentialManager()
    
    private init(){
        
    }
    
    func getUserId() -> String? {
        return KeychainManager.shared.keychain.get("userId")
    }
}
