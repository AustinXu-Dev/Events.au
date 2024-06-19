//
//  TokenManager.swift
//  Events.au
//
//  Created by Akito Daiki on 09/06/2024.
//

import Foundation
import KeychainAccess

class TokenManager: ObservableObject {
    
    @Published var isTokenValid = false
    static let share = TokenManager()
    
    // MARK: - Save Tokens in keychain
    func saveTokens(token: String) {
        do {
            try KeychainManager.shared.keychain.set(token, key: "userToken")
            print("Saved Tokens: \(String(describing: try KeychainManager.shared.keychain.get("userToken")))")
        } catch {
            print("Error saving tokens: \(error)")
        }
    }
    
    // MARK: - Get Tokens for headers and API calls
    func getToken() -> String? {
        do {
            return try KeychainManager.shared.keychain.get("userToken")
        } catch {
            print("Error retrieving token: \(error)")
            return nil
        }
    }
    
    // MARK: - Delete Tokens
    func deleteToken() {
        do {
            try KeychainManager.shared.keychain.remove("userToken")
            print("All token deleted")
        } catch {
            print("Error deleting token: \(error)")
        }
    }
}
