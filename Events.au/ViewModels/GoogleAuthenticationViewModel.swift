//
//  GoogleAuthenticationViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 09/06/2024.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth

class GoogleAuthenticationViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var isAuthenticated: Bool = false
    @Published var token: String? = nil
    
    //MARK: - Goolge Sign In Function
    func signInWithGoogle(presenting: UIViewController, completion: @escaping (Error?, Bool) -> Void) {
        
        guard let clientID = FirebaseManager.shared.firebaseApp?.options.clientID else {
            self.errorMessage = "Missing Firebase Client ID"
            DispatchQueue.main.async {
                completion(NSError(domain: "GoogleAuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing Firebase client ID."]), false)
            }
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { user, error in
            if let error = error {
                self.errorMessage = "Failed to Sign In with instance: \(error)"
                DispatchQueue.main.async {
                    completion(error, false)
                }
                return
            }
            
            guard let user = user?.user, let idToken = user.idToken else {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                return
            }
            
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            //MARK: - Trigerring SignIn Function from Firebase Auth
            FirebaseManager.shared.auth.signIn(with: credential) { authResult, error in
                if let error = error {
                    self.errorMessage = "Failed to Sign In with credentials: \(error)"
                    DispatchQueue.main.async {
                        completion(error, false)
                    }
                    return
                }
                
                guard let authResult = authResult else {
                    self.errorMessage = "Authentication result is nil: \(String(describing: error))"
                    DispatchQueue.main.async {
                        completion(NSError(domain: "FirebaseAuthError", code: -1, userInfo: nil), false)
                    }
                    return
                }
                
                //MARK: - Handling new user state during sign in
                let isNewUser = authResult.additionalUserInfo?.isNewUser ?? false
                DispatchQueue.main.async {
                    completion(nil, isNewUser)
                }
                
                //MARK: - Condition with Token Valid and Login successful with google auth
                if !isNewUser{
                    if let email = authResult.user.email {
                        let firebaseId = authResult.user.uid
                        self.postFirebaseId(firebaseId: firebaseId)
                        DispatchQueue.main.async {
                            TokenManager.share.isTokenValid = true
                            print(TokenManager.share.isTokenValid, "Token state")
                        }
                    }
                    print("This user already exists")
                } else {
                    print("There's a new user!!!")
                    if let email = authResult.user.email {
                        let firebaseId = authResult.user.uid
//                        self.postFirebaseId(firebaseId: firebaseId)
                        DispatchQueue.main.async {
                            //post new user here
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Posting to signin API with firebase id if the user already exists
    private func postFirebaseId(firebaseId: String) {
        let webService = WebService()
        webService.signin(firebaseId: firebaseId) { result in
            switch result {
            case .success(let token):
                print("Login successful with token: \(token)")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.token = token
                    TokenManager.share.saveTokens(token: token)
                }
            case .failure(let error):
                print("Login failed with error: \(error)")
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to login with WebService: \(error)"
                }
            }
        }
    }
    
    //MARK: - Handling Sign In Error
    private func handleSignInError(message: String, error: Error?, completion: @escaping (Error?, Bool) -> Void) {
        self.errorMessage = message
        DispatchQueue.main.async {
            completion(error, false)
        }
    }
    
    //MARK: - User Existance Check
    func checkIfUserExists(completion: @escaping (Bool) -> Void) {
        let user = FirebaseManager.shared.auth.currentUser
        completion(user != nil)
    }
    
    //MARK: - Goolge Sign Out Function
    func signOutWithGoogle() {
        do {
            try FirebaseManager.shared.auth.signOut()
            DispatchQueue.main.async {
                TokenManager.share.deleteToken()
                self.isAuthenticated = false
                TokenManager.share.isTokenValid = false
                self.token = nil
            }
        } catch let signOutError as NSError {
            self.errorMessage = "Failed to sign out with error: \(signOutError)"
        }
    }
}
