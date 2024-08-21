//
//  TestSignUp.swift
//  Events.au
//
//  Created by Akito Daiki on 09/06/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


class UserSignUpViewModel: ObservableObject {
    
    enum SignUpError: Error {
        case networkError
        case invalidResponse
        case serverError(String)
        
        var localizedDescription: String {
            switch self {
            case .networkError:
                return "Network error occurred."
            case .invalidResponse:
                return "Invalid response from server."
            case .serverError(let message):
                return "Server error: \(message)"
            }
        }
    }
    
    func postUser(firstName: String, email: String, phone: Int, fId: String, unitId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        // Construct URL and URLRequest
        guard let url = URL(string: "https://events-au-v2.vercel.app/auth/signup") else {
            completion(.failure(SignUpError.invalidResponse))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create payload data
        let body: [String: Any] = [
            "firstName": firstName,
            "email": email,
            "phone": phone,
            "fId": fId,
            "unitId": unitId
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        // Perform the URLRequest
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(SignUpError.invalidResponse))
                    return
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    let errorMessage = String(data: data ?? Data(), encoding: .utf8) ?? "Unknown error"
                    completion(.failure(SignUpError.serverError(errorMessage)))
                    return
                }
                
                // Successful registration, It's just for checking user _id available after sign up. Don't need that logic in App
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Response JSON: \(jsonResponse)")
                            
                            if let message = jsonResponse["message"] as? [String: Any],
                               let userId = message["_id"] as? String {
                                // Save _id to UserDefaults
                                UserDefaults.standard.set(userId, forKey: "userId")
                                print("User ID saved successfully!")
                                self.printStoredUserId()
                                //store photo URL here
                             

                                
                                completion(.success(()))
                            } else {
                                completion(.failure(SignUpError.invalidResponse))
                            }
                        } else {
                            completion(.failure(SignUpError.invalidResponse))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(SignUpError.invalidResponse))
                }
            }
        }.resume()
    }
    
    func printStoredUserId() {
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            print("Stored User ID: \(userId)")
        } else {
            print("No User ID found in UserDefaults.")
        }
    }
}
