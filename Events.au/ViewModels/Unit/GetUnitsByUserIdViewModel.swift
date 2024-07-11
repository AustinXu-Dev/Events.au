//
//  GetUnitsByUserIdViewModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 11/07/2024.
//

import Foundation

class GetUnitsByUserIdViewModel : ObservableObject {
    @Published var userUnits : [UnitModel] = []
    @Published var errorMessage : String? = nil
    @Published var loader : Bool = false
    
    func getUnitsByUserId(id:String) {
        self.loader = true
        let unitUserURL = AllUnitsByUserId(id: id)
        unitUserURL.execute(getMethod:"GET",token: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let returnedUserUnits) :
                    self?.loader = false
                    self?.userUnits = returnedUserUnits.message
                case .failure(let error) :
                    self?.loader = false
                    self?.errorMessage = "Failed to get units of a user by userId. \(error.localizedDescription)"
                }
                
                
            }
        }
    }
    
}

