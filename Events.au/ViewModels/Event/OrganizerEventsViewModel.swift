//
//  OrganizerEventsViewModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 15/07/2024.
//

import Foundation

class OrganizerEventsViewModel : ObservableObject {
    @Published var organizerEvents: [OrganizerModel] = []
    @Published var loader : Bool = false
    @Published var errorMessage : String? = nil
    
    //MARK: This is for fetching all events but they're hosted by the organizer
    func fetchEventsByOrganizer(id: String) {
        loader = true
        let getEventsURL = AllEventsByUserId(id: id)
        getEventsURL.execute(getMethod: "GET", token: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let eventsOfOrganizer):
                    self?.loader = false
                    self?.organizerEvents = eventsOfOrganizer.message
                    self?.readEventStatus(organizer: self?.organizerEvents ?? OrganizerMock.instance.organizer3)
                case .failure(let error):
                    self?.loader = false
                    self?.errorMessage = "Failed to get events by organizer id.\(error.localizedDescription)"
                }
            }
        }
    }
    
    func readEventStatus(organizer : [OrganizerModel]) {
        organizer.forEach { organizer in
            print(organizer.status ?? "")
        }
    }
}
