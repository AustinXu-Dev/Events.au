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

struct LoginRequestBody: Codable {
    let firebaseId: String
}

struct LoginResponse: Codable {
    let token: String?
}

enum AuthenticationError: Error {
    case custom(errorMessage: String)
    case invalidCredentials
    case serverError
}

// MARK: - Getting the token from the API with email and firebaseId
class WebService {
    
    func signin(firebaseId: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "https://events-au-v2.vercel.app/auth/signin") else {
            completion(.failure(.custom(errorMessage: "This is not the correct URL!")))
            return
        }
        
        // MARK: - form-data body to post to API
        let body = LoginRequestBody(firebaseId: firebaseId)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(.custom(errorMessage: "Failed to encode request body.")))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(.custom(errorMessage: "No Data")))
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
            
            guard let data = data else {
                completion(.failure(.custom(errorMessage: "No Data")))
                return
            }
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                if let token = loginResponse.token {
                    completion(.success(token))
                    print("Status : \(httpResponse.statusCode)")
                } else if httpResponse.statusCode == 401 {
                    completion(.failure(AuthenticationError.invalidCredentials))
                    TokenManager.share.isTokenValid = false
                    print("Authorization Error!!!")
                } else {
                    completion(.failure(.invalidCredentials))
                    TokenManager.share.isTokenValid = false
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(.custom(errorMessage: "Failed to decode response.")))
            }
        }
        .resume()
    }
}
