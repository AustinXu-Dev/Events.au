//
//  KeychainManager.swift
//  Events.au
//
//  Created by Akito Daiki on 17/06/2024.
//

import Foundation
import KeychainAccess

class KeychainManager {
    static let shared = KeychainManager()
    
    let keychain: Keychain
    
    private init() {
        keychain = Keychain(service: "com.austinxu.decode.events-au")
    }
}
