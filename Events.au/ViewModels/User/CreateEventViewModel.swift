//
//  CreateEventViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 22/06/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

class CreateEventViewModel: ObservableObject {
    
    @Published var name: String
    @Published var description: String
    @Published var location: String
    @Published var startDate: String
    @Published var endDate: String
    @Published var startTime: String
    @Published var endTime: String
    @Published var rules: String
    @Published var coverImageUrl: String
    @Published var unitId: String
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    
    //https://lh3.googleusercontent.com/a/ACg8ocJWN9H5pN0ecH3xit1l8PFbf4oE7bVeMTepu3zjnvUKJwynsQ=s96-c
    init(name: String = "", description: String = "", location: String = "", startDate: String = "", endDate: String = "", startTime: String = "", endTime: String = "", rules: String = "", coverImageUrl: String =
         "", unitId: String = "") {
        self.name = name
        self.description = description
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        self.startTime = startTime
        self.endTime = endTime
        self.rules = rules
        self.coverImageUrl = coverImageUrl
        self.unitId = unitId
    }
    
    func createEvent(token: String) {
        let newEvent = CreateEventDTO(
            name: name,
            description: description,
            location: location,
            startDate: startDate,
            endDate: endDate,
            startTime: startTime,
            endTime: endTime,
            rules: rules,
            coverImageUrl: coverImageUrl,
            unitId: unitId
        )
        
        let createEventManager = UserCreateEvent()
        isLoading = true
        errorMessage = nil
        
        createEventManager.execute(data: newEvent, getMethod: "POST", token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let event):
                    print("Event created successfully")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to create event: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func storeImageUrl(imageUrl: String, uid: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        userRef.setData([
            "imageUrl": imageUrl,
            "email": email
        ], merge: true) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func retrieveImageUrl(uid: String, completion: @escaping (Result<String, Error>) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        userRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                if let imageUrl = document.data()?["imageUrl"] as? String {
                    completion(.success(imageUrl))
                } else {
                    completion(.failure(NSError(domain: "Firestore", code: 0, userInfo: [NSLocalizedDescriptionKey: "Image URL not found"])))
                }
            } else {
                completion(.failure(NSError(domain: "Firestore", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])))
            }
        }
    }
    
    func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let storageRef = Storage.storage().reference().child("images/\(UUID().uuidString).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(.failure(NSError(domain: "ImageError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get image data"])))
            return
        }
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let downloadURL = url?.absoluteString else {
                    completion(.failure(NSError(domain: "ImageError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get download URL"])))
                    return
                }
                
                completion(.success(downloadURL))
            }
        }
    }
}

