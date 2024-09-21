//
//  SignInEmailPasswordViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 27/08/2024.
//

import Foundation
import Combine
 
class SignInEmailPasswordViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var isAuthenticated: Bool = false
    @Published var token: String? = nil
    @Published var tokenIsExpired : Bool = false
    
    var timer : AnyCancellable?
    var expirationDate : Date?
    
    init() {
        loadTokenExpirationDate()
        startTokenExpiryCheck() // Start the timer-based check
    }
    
    deinit {
        timer?.cancel() // Cancel the timer when the view model is deallocated
    }
 
    // MARK: - Posting to signin API with firebase id if the user already exists
    func postSignInFirebaseId(firebaseId: String, email: String) {
        let webService = WebService()
        webService.signin(firebaseId: firebaseId, email: email) { result in
            switch result {
            case .success(let (token, userId)):
//                print("Login successful with token: \(token)")
//                print("Login successful with user _id: \(userId)")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.token = token
                    TokenManager.share.saveTokens(token: token)
//                    print("Token is",token)
                    // Save the token and expiration date (3 days from now)
                    let tokenReceivedDate = Date()
                    self.expirationDate = Calendar.current.date(byAdding: .day, value: 3, to: tokenReceivedDate)
                    UserDefaults.standard.set(self.expirationDate, forKey: "TokenExpirationDate")
                    
                    self.checkTokenExpiry()
                    KeychainManager.shared.keychain.set(userId, forKey: "appUserId")
                    if TokenManager.share.getToken() != nil {
                        UserDefaults.standard.set(true, forKey: "appState")
                    }
                }
            case .failure(let error):
//                print("Login failed with error: \(error)")
                DispatchQueue.main.async {
                    UserDefaults.standard.set(false, forKey: "appState")
                    self.errorMessage = "Failed to login with WebService: \(error)"
                }
            }
        }
    }
    
    func loadTokenExpirationDate() {
        if let savedExpirationDate = UserDefaults.standard.object(forKey: "TokenExpirationDate") as? Date {
            expirationDate = savedExpirationDate
            checkTokenExpiry()
        }
    }
    
    func checkTokenExpiry() {
        if let expirationDate = expirationDate {
            self.tokenIsExpired = Date() >= expirationDate
        }
    }
    
    func startTokenExpiryCheck() {
        // Set a timer to check every 3 hours
        timer = Timer.publish(every: 10800, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.checkTokenExpiry()
            }
    }
    
}
