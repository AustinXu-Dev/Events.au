//
//  TestSignUp.swift
//  Events.au
//
//  Created by Akito Daiki on 09/06/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
 
enum SignUpError: Error {
    case custom(errorMessage: String)
    case invalidResponse
    case serverError(String)
}

// MARK: - User Sign-Up View Model
class UserSignUpViewModel: ObservableObject {
    
    func postUser(firstName: String, email: String, phone: Int, fId: String, completion: @escaping (Result<(String, String), SignUpError>) -> Void) {
        
        guard let url = URL(string: "https://events-au-v2.vercel.app/auth/signup") else {
            completion(.failure(.custom(errorMessage: "Invalid URL")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "firstName": firstName,
            "email": email,
            "phone": phone,
            "password": fId
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(.custom(errorMessage: "Failed to encode request body")))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.custom(errorMessage: "Network error: \(error.localizedDescription)")))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    let errorMessage = String(data: data ?? Data(), encoding: .utf8) ?? "Unknown error"
                    completion(.failure(.serverError(errorMessage)))
                    return
                }
                
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let message = jsonResponse["message"] as? [String: Any],
                           let token = message["token"] as? String,
                           let user = message["user"] as? [String: Any],
                           let userId = user["_id"] as? String {
                            // Return the token and userId
                            completion(.success((token, userId)))
                        } else {
                            completion(.failure(.invalidResponse))
                        }
                    } catch {
                        completion(.failure(.custom(errorMessage: "Error decoding response: \(error.localizedDescription)")))
                    }
                } else {
                    completion(.failure(.invalidResponse))
                }
            }
        }.resume()
    }
}

 
//class UserSignUpViewModel: ObservableObject {
//    
//    enum SignUpError: Error {
//        case networkError
//        case invalidResponse
//        case serverError(String)
//        
//        var localizedDescription: String {
//            switch self {
//            case .networkError:
//                return "Network error occurred."
//            case .invalidResponse:
//                return "Invalid response from server."
//            case .serverError(let message):
//                return "Server error: \(message)"
//            }
//        }
//    }
//    
//    func postUser(firstName: String, email: String, phone: Int, fId: String, completion: @escaping (Result<String, String>) -> Void) {
//        
//        // Construct URL and URLRequest
//        guard let url = URL(string: "https://events-au-v2.vercel.app/auth/signup") else {
//            completion(.failure(SignUpError.invalidResponse))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Create payload data
//        let body: [String: Any] = [
//            "firstName": firstName,
//            "email": email,
//            "phone": phone,
//            "password": fId
//        ]
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
//        } catch {
//            completion(.failure("Invalid URL"))
//            return
//        }
//        
//        // Perform the URLRequest
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//                
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    completion(.failure(SignUpError.invalidResponse))
//                    return
//                }
//                
//                if !(200...299).contains(httpResponse.statusCode) {
//                    let errorMessage = String(data: data ?? Data(), encoding: .utf8) ?? "Unknown error"
//                    completion(.failure(SignUpError.serverError(errorMessage)))
//                    return
//                }
//                
//                // Successful registration, It's just for checking user _id available after sign up. Don't need that logic in App
//                if let data = data {
//                    do {
//                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                            if let message = jsonResponse["message"] as? [String: Any],
//                               let token = message["token"] as? String,
//                               let user = message["user"] as? [String: Any],
//                               let userId = user["_id"] as? String {
//                                completion(.success(()))
//                                TokenManager.share.saveTokens(token: token)
//                                KeychainManager.shared.keychain.set(userId, forKey: "appUserId")
//                                
//                            } else {
//                                completion(.failure(SignUpError.invalidResponse))
//                            }
//                        } else {
//                            completion(.failure(SignUpError.invalidResponse))
//                        }
//                    } catch {
//                        completion(.failure(error))
//                    }
//                } else {
//                    completion(.failure(SignUpError.invalidResponse))
//                }
//            }
//        }.resume()
//    }
//}
