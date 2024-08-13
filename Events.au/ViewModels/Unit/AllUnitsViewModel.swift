//
//  AllUnitsViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 19/06/2024.
//

import Foundation

class AllUnitsViewModel: ObservableObject {
    @Published var units: [UnitModel] = []
    
    private let getAllUnits = AllUnits()
    
    init(){
        fetchUnits()
    }
    
    func fetchUnits() {
        getAllUnits.execute(token: nil) { [weak self] result in
            switch result {
            case .success(let unitResponse):
                DispatchQueue.main.async {
                    self?.units = unitResponse.message
//                    print(unitResponse.message)
                }
            case .failure(let error):
                print("Failed to fetch events: \(error)")
                // Handle error, e.g., show an alert
            }
        }
    }
}
