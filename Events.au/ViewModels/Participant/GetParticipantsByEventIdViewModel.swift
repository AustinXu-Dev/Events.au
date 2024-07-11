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
        print("FETCHED APPROVED PARTICIPANTS IN VIEW MODEL")
        return allParticipants.filter { $0.status == "pending" || $0.status == "participating" }
     }
     
    
    func fetchParticipants(id:String) {
        let eventParticipantsURL = GetParticipantByEventId(eventId: id)
        eventParticipantsURL.execute(getMethod:"GET",token: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedParticipants):
                    print("FETCHED ALL PARTICIPANTS IN VIEW MODEL")
                    print("Participants Total: \(fetchedParticipants.message.count)")
                    self?.allParticipants = fetchedParticipants.message
                case .failure(let error):
                    self?.errorMessage = "Error fetching the participants of an event. \(error.localizedDescription)"
                }
            }
        }
    }
    
    
    
    
    
}
