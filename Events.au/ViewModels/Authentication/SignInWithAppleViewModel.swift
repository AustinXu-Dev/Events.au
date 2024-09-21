//
//  SignInWithAppleViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 20/09/2024.
//

import AuthenticationServices
import Firebase
import CryptoKit
import Combine
import SwiftUI
import Combine

class SignInWithAppleViewModel: ObservableObject {
    
    @Published var errorMessage: String? = nil
    @Published var tokenIsExpired : Bool = false
    var timer : AnyCancellable?
    var expirationDate : Date?
    private var nonce: String?
    
    let userSignupViewModel = UserSignUpViewModel()
    
    init() {
        loadTokenExpirationDate()
        startTokenExpiryCheck() // Start the timer-based check
    }
    
    deinit {
        timer?.cancel() // Cancel the timer when the view model is deallocated
    }
    
    // MARK: - Firebase Sign In Logic
    private func loginWithFirebase(_ authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            self.errorMessage = "Invalid state: A login callback was received, but no login request was sent."
            return
        }
        
        guard let nonce = nonce else {
            fatalError("Invalid state: No nonce available.")
        }
        
        guard let appleIDToken = appleIDCredential.identityToken else {
            self.errorMessage = "Unable to fetch identity token."
            return
        }
        
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            self.errorMessage = "Unable to serialize token string."
            return
        }
        
        let credential = OAuthProvider.appleCredential(withIDToken: idTokenString, rawNonce: nonce, fullName: appleIDCredential.fullName)
        
        // Firebase sign in with the Apple credential
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            let isNewUser = authResult?.additionalUserInfo?.isNewUser ?? false
            if isNewUser {
                self.handleNewUserSignUp(authResult: authResult)
            } else {
                self.postSignInFirebaseId(firebaseId: authResult?.user.uid ?? "", email: authResult?.user.email ?? "")
            }
        }
    }
    
    // MARK: - Configure Apple Sign In Request
    func configureAppleSignInRequest(request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        self.nonce = nonce
        request.requestedScopes = [.email, .fullName]
        request.nonce = sha256(nonce)
    }
    
    // MARK: - Handle Apple Sign In Completion
    func handleAppleSignInCompletion(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            loginWithFirebase(authorization)
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Handle New User Sign Up
    private func handleNewUserSignUp(authResult: AuthDataResult?) {
        userSignupViewModel.postUser(firstName: authResult?.user.displayName ?? "", email: authResult?.user.email ?? "", phone: -1, fId: authResult?.user.uid ?? "") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let (token, userId)):
                TokenManager.share.saveTokens(token: token)
                KeychainManager.shared.keychain.set(userId, forKey: "appUserId")
                DispatchQueue.main.async{
                    if TokenManager.share.getToken() != nil {
                        UserDefaults.standard.set(true, forKey: "appState")
                    }
                }
                
            case .failure(let error):
                print("Failed to sign up new Apple user: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    // MARK: - Post Existing User Sign In
    private func postSignInFirebaseId(firebaseId: String, email: String) {
        let webService = WebService()
        webService.signin(firebaseId: firebaseId, email: email) { result in
            switch result {
            case .success(let (token, userId)):
                DispatchQueue.main.async {
                    TokenManager.share.saveTokens(token: token)
                    KeychainManager.shared.keychain.set(userId, forKey: "appUserId")
                    // Save the token and expiration date (3 days from now)
                    let tokenReceivedDate = Date()
                    self.expirationDate = Calendar.current.date(byAdding: .day, value: 3, to: tokenReceivedDate)
                    UserDefaults.standard.set(self.expirationDate, forKey: "TokenExpirationDate")
                    self.checkTokenExpiry()
                    if TokenManager.share.getToken() != nil {
                        UserDefaults.standard.set(true, forKey: "appState")
                    }
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    UserDefaults.standard.set(false, forKey: "appState")
                }
            }
        }
    }
    
    // MARK: - Utility Functions
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        return String(randomBytes.map { charset[Int($0) % charset.count] })
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.map { String(format: "%02x", $0) }.joined()
    }
    
    // MARK: - Token Expiration Timer
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
