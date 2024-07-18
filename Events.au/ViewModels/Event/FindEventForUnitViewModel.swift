//
//  FindEventForUnitViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 09/07/2024.
//

import Foundation

class FindEventForUnitViewModel: ObservableObject {
    
    @Published var eventUnit: [EventUnitModel] = []
    @Published var errorMessage: String? = nil
    
    func findEventForAUnit(id: String) {
        errorMessage = nil
        let getEvent = FindEventForUnit(id: id)
        getEvent.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let eventResult):
                    self.eventUnit = eventResult.message
                    print("Event for a Unit: \(eventResult.message)")
                case .failure(let error):
                    self.errorMessage = "Failed to get event for a unit."
                    print(error.localizedDescription)
                }
            }
        }
    }
}
