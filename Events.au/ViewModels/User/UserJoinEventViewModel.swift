//
//  UserJoinEventViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 09/07/2024.
//

import Foundation

class UserJoinEventViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func userJoinEvent(eventId: String, token: String) {

        let userJoinedEvent = UserJoinEvent(id: eventId)
        isLoading = true
        errorMessage = nil

        userJoinedEvent.execute(getMethod: "POST", token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let participantStatusResult):
//                    print("Event basic info updated successfully: \(participantStatusResult)")
                    print("Event basic info updated successfully")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to create event: \(error)")
                }
            }
        }
    }
}
