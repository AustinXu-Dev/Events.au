//
//  UpdateParticipantStatusViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 09/07/2024.
//

import Foundation

class UpdateParticipantStatusViewModel: ObservableObject {
    
    @Published var participantId: String
    @Published var status: String
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    init(participantId: String = "", status: String = "") {
        self.participantId = participantId
        self.status = status
    }

    func updateEventBasicInfo(eventId: String, token: String) {
        let updatedStatus = ParticipantApprovalDTO(
            participantId: participantId,
            status: status
        )

        let updateParticipantStatus = UpdateParticipantStatus(eventId: eventId)
        isLoading = true
        errorMessage = nil

        updateParticipantStatus.execute(data: updatedStatus, getMethod: "PUT", token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let participantStatusResult):
                    print("Event basic info updated successfully: \(participantStatusResult)")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to create event: \(error)")
                }
            }
        }
    }
}
