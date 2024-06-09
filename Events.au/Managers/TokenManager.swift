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
    private let keychain = Keychain(service: "course_cyclopedia_user_tokens")
    
    // MARK: - Save Tokens in keychain
    func saveTokens(token: String) {
        do {
            try keychain.set(token, key: "userToken")
        } catch {
            print("Error saving tokens: \(error)")
        }
    }
    
    // MARK: - Get Tokens for headers and API calls
    func getToken() -> String? {
        do {
            return try keychain.get("userToken")
        } catch {
            print("Error retrieving token: \(error)")
            return nil
        }
    }
    
    // MARK: - Delete Tokens
    func deleteToken() {
        do {
            try keychain.remove("userToken")
            print("All token deleted")
        } catch {
            print("Error deleting token: \(error)")
        }
    }
}
