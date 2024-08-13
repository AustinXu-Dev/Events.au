//
//  GetParticipantByIdViewModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 08/07/2024.
//

import Foundation
import Combine

class GetParticipantsByEventIdViewModel : ObservableObject {
    
    @Published var allParticipants : [ParticipantModel] = []
    @Published var errorMessage : String = ""
    
    
    
    var approvedParticipants: [ParticipantModel] {
        return allParticipants.filter { $0.status == "participating" }
     }
     
    //checking if the event has participant or not
    func participantExists(userId: String) -> Bool {
         return allParticipants.contains { $0._id == userId }
     }
    
    func fetchParticipants(id:String) {
        let eventParticipantsURL = GetParticipantByEventId(id: id)
        eventParticipantsURL.execute(getMethod:"GET",token: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedParticipants):
//                    print("All Participants Total: \(fetchedParticipants.message) of the eventId : \(id)")
                    self?.allParticipants = fetchedParticipants.message
                case .failure(let error):
                    self?.errorMessage = "Error fetching the participants of an event. \(error.localizedDescription)"
                }
            }
        }
    }
}
