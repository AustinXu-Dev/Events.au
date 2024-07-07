//
//  GetUnitsByEventIdViewModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 08/07/2024.
//

import Foundation

class GetUnitsByEventViewModel : ObservableObject {
    
    @Published var eventUnits : [EventUnitModel] = []
    @Published var errorMessage : String? = nil
    @Published var loader : Bool = false
    
    func getUnitsByEvent(id : String) {
        self.loader = true
        let eventUnitURL = AllUnitsByEventId(id: id)
        eventUnitURL.execute(getMethod: "GET",token: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let returnedEventUnits):
                    self?.loader = false
                    self?.eventUnits = returnedEventUnits.message
                    print("Event Units: \(returnedEventUnits)")
                case .failure(let error):
                    self?.loader = false
                    self?.errorMessage = "Failed to get units of an event by eventId. \(error.localizedDescription)"
                    
                }
            }
        }
        
        
    }
    
}
 
