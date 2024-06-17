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
    @Published var isNewUser: Bool = false
    @Published var fId: String?
    @Published var email: String?
    @Published var userId: String?
    
    
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
                    DispatchQueue.main.async {
                        self.postSignInFirebaseId(firebaseId: authResult.user.uid)
                    }
                    TokenManager.share.isTokenValid = true
                    print("This user already exists.")
                } else {
                    if authResult.user.email != nil {
                        _ = authResult.user.uid
                        DispatchQueue.main.async {
                            //post new user here
                            print("There's a new user.")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Posting to signin API with firebase id if the user already exists
    private func postSignInFirebaseId(firebaseId: String) {
        let webService = WebService()
        webService.signin(firebaseId: firebaseId) { result in
            switch result {
            case .success(let (token, userId)):
                print("Login successful with token: \(token)")
                print("Login successful with user _id: \(userId)")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.token = token
                    self.userId = userId
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
    
    func signUpWithGoogle(presenting: UIViewController, completion: @escaping (Error?, Bool) -> Void) {
        
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
                
                self.fId = authResult.user.uid
                self.email = authResult.user.email
                
                //MARK: - Handling new user state during sign in
                let isNewUser = authResult.additionalUserInfo?.isNewUser ?? false
                DispatchQueue.main.async {
                    completion(nil, isNewUser)
                }

                //MARK: - Condition with Token Valid and Login successful with google auth
                if isNewUser{
                    print("There's a new user!!!")
                } else {
                    print("This user already exists")
                }
            }
        }
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
