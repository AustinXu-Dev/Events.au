//
//  GetParticipantsByUserIdViewModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 18/08/2024.
//

import Foundation

import Combine

class GetParticipantsByUserIdViewModel : ObservableObject {
    
    @Published var participant : [ParticipantModel] = []
    @Published var errorMessage : String = ""
  
   
    func fetchParticipant(id:String) {
        let participantURL = GetParticipantByUserId(id: id)
        participantURL.execute(getMethod:"GET",token: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedParticipant):
                    print("Participant by USer ID fetched")
                    self?.participant = fetchedParticipant.message
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.errorMessage = "Error fetching the participants of an event. \(error.localizedDescription)"
                }
            }
        }
    }
}





