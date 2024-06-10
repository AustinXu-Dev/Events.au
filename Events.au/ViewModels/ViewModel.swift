//
//  ViewModel.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/6.
//

import Foundation

//MARK: This is dummy file ViewModels Group

class MyViewModel : APIManager {
    @Published var allEvents : [EventModel] = []

    var methodPath: String {
        return "/events"
    }
    
    
    typealias ModelType = [EventModel]
    
    
    init(){
        fetchEvents()
    }
    
    func fetchEvents(){
        let requestBody = CreateEventDTO(name: "", unitId: "")
        
        execute(data:requestBody,getMethod: "POST") { result in
            switch result {
            case .success(let events):
                self.allEvents = events
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

