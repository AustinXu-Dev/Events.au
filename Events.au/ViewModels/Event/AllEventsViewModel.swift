//
//  AllEventsViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 16/06/2024.
//

import Foundation

class AllEventsViewModel: ObservableObject {
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
                    self?.events = eventResponse.message.filter{ $0.status == "approved"}
                }
            case .failure(let error):
                self?.loader = false
            }
        }
    }
    
    var approvedEvents : [EventModel] {
        return events.filter { $0.status == "approved" }
     }
    
    
     
    
}
