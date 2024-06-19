//
//  WebService.swift
//  Events.au
//
//  Created by Akito Daiki on 09/06/2024.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

enum AuthenticationError: Error {
    case custom(errorMessage: String)
    case invalidCredentials
    case serverError
}

// MARK: - Getting the token from the API with email and firebaseId
class WebService {
    
    func signin(firebaseId: String, completion: @escaping (Result<(String, String), AuthenticationError>) -> Void) {
        guard let url = URL(string: "https://events-au-v2.vercel.app/auth/signin") else {
            completion(.failure(.custom(errorMessage: "Invalid URL")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["fId": firebaseId]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(.custom(errorMessage: "Failed to encode request body")))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(.custom(errorMessage: "Network error")))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.serverError))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.custom(errorMessage: "Server responded with status code \(httpResponse.statusCode)")))
                return
            }
            
            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let message = jsonResponse["message"] as? [String: Any],
                       let token = message["token"] as? String,
                       let user = message["user"] as? [String: Any],
                       let userId = user["_id"] as? String {
                        // Store user ID in Keychain
                        try KeychainManager.shared.keychain.set(userId, key: "appUserId")
                        
                        // Return the token and user ID
                        completion(.success((token, userId)))
                    } else {
                        completion(.failure(.custom(errorMessage: "Invalid response format")))
                    }
                } catch {
                    completion(.failure(.custom(errorMessage: "Error decoding response: \(error.localizedDescription)")))
                }
            } else {
                completion(.failure(.serverError))
            }
        }
        .resume()
    }
}
