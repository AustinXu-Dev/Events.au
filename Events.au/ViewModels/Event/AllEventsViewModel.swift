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
    
    private let getAllEvents = AllEvents()
    
    func fetchEvents() {
        loader = true
        getAllEvents.execute(token: nil) { [weak self] result in
            switch result {
            case .success(let eventResponse):
                DispatchQueue.main.async {
                    self?.loader = false
                    self?.events = eventResponse.message
                    print(eventResponse.message)
                }
            case .failure(let error):
                self?.loader = false
                print("Failed to fetch events: \(error)")
                // Handle error, e.g., show an alert
            }
        }
    }
}
