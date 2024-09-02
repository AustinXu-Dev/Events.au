//
//  FindUnitsForAUser.swift
//  Events.au
//
//  Created by Akito Daiki on 09/07/2024.
//

import Foundation

class FindUnitsForAUserViewModel: ObservableObject {
    
    @Published var units: [UnitModel] = []
    @Published var errorMessage: String? = nil
    
    func getUnits(id: String) {
        errorMessage = nil
        let getUnitsForUser = FindUnitsForAUser(id: id)
        getUnitsForUser.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let unitsResult):
                    self.units = unitsResult.message
                case .failure(_):
                    self.errorMessage = "Failed to get user detail by id."
                }
            }
        }
    }
}
