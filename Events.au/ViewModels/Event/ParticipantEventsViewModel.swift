//
//  ParticipantEventsViewModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 07/08/2024.
//

import Foundation

class ParticipantEventsViewModel : ObservableObject {
    @Published var participantEvents: [ParticipantModel] = []
    @Published var loader : Bool = false
    @Published var errorMessage : String? = nil
    
    func fetchEvents(userId:String) {
        loader = true
        let getAllEvents = AllParticipantEventsByUserId(userId: userId)
        getAllEvents.execute(token:nil) { [weak self] result in
            switch result {
            case .success(let eventResponse):
                DispatchQueue.main.async {
                    self?.loader = false
                    self?.participantEvents = eventResponse.message
                }
            case .failure(let error):
                self?.loader = false
                self?.errorMessage = error.localizedDescription
            }
            
            
            
        }
    }
    
   
}



/*
 @Published var events: [EventModel] = []
 @Published var loader : Bool = false
 @Published var errorMessage : String? = nil
 
 private let getAllEvents = AllEvents()
 
 //MARK: This is for fetching all events for participants
 func fetchEvents() {
     loader = true
     getAllEvents.execute(token: nil) { [weak self] result in
         switch result {
         case .success(let eventResponse):
             DispatchQueue.main.async {
                 self?.loader = false
                 self?.events = eventResponse.message
                 print("FETCHED EVENTS IN HOME VIEW")
             }
         case .failure(let error):
             self?.loader = false
             print("Failed to fetch events: \(error)")
             // Handle error, e.g., show an alert
         }
     }
 */
