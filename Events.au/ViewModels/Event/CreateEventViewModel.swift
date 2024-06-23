//
//  CreateEventViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 22/06/2024.
//

import Foundation

//class CreateEventViewModel: ObservableObject {
//    @Published var name: String
//    @Published var description: String
//    @Published var location: String
//    @Published var startDate: String
//    @Published var endDate: String
//    @Published var startTime: String
//    @Published var endTime: String
//    @Published var rules: String
//    @Published var imageUrl: String
//    @Published var unitId: String
//
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String? = nil
//
//    init(name: String = "", description: String = "", location: String = "", startDate: String = "", endDate: String = "", startTime: String = "", endTime: String = "", rules: String = "", imageUrl: String = "", unitId: String = "66704d5453650896c379d69a") {
//        self.name = name
//        self.description = description
//        self.location = location
//        self.startDate = startDate
//        self.endDate = endDate
//        self.startTime = startTime
//        self.endTime = endTime
//        self.rules = rules
//        self.imageUrl = imageUrl
//        self.unitId = unitId
//    }
//
//    func createEvent(token: String) {
//        let newEvent = CreateEventDTO(
//            name: name,
//            description: description,
//            location: location,
//            startDate: startDate,
//            endDate: endDate,
//            startTime: startTime,
//            endTime: endTime,
//            rules: rules,
//            imageUrl: imageUrl,
//            unitId: unitId
//        )
//
//        let data = createEventData(from: newEvent)
//        let createEventManager = CreateEvent()
//        isLoading = true
//        errorMessage = nil
//
//        createEventManager.execute(data: data, getMethod: "POST", token: token) { [weak self] result in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                switch result {
//                case .success(let event):
//                    print("Event created successfully: \(event)")
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                    print("Failed to create event: \(error)")
//                }
//            }
//        }
//    }
//
//    private func createEventData(from event: CreateEventDTO) -> [String: Any] {
//        return [
//            "name": event.name,
//            "description": event.description,
//            "location": event.location,
//            "startDate": event.startDate,
//            "endDate": event.endDate,
//            "startTime": event.startTime,
//            "endTime": event.endTime,
//            "rules": event.rules,
//            "imageUrl": event.imageUrl,
//            "unitId": event.unitId
//        ]
//    }
//}
//


class CreateEventViewModel: ObservableObject {
    @Published var name: String
    @Published var description: String
    @Published var location: String
    @Published var startDate: String
    @Published var endDate: String
    @Published var startTime: String
    @Published var endTime: String
    @Published var rules: String
    @Published var imageUrl: String
    @Published var unitId: String

    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    init(name: String = "", description: String = "", location: String = "", startDate: String = "", endDate: String = "", startTime: String = "", endTime: String = "", rules: String = "", imageUrl: String = "https://lh3.googleusercontent.com/a/ACg8ocJWN9H5pN0ecH3xit1l8PFbf4oE7bVeMTepu3zjnvUKJwynsQ=s96-c", unitId: String = "66704d5453650896c379d69a") {
        self.name = name
        self.description = description
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        self.startTime = startTime
        self.endTime = endTime
        self.rules = rules
        self.imageUrl = imageUrl
        self.unitId = unitId
    }

    func createEvent(token: String) {
        let newEvent = CreateEventDTO(
            name: name,
            description: description,
            location: location,
            startDate: startDate,
            endDate: endDate,
            startTime: startTime,
            endTime: endTime,
            rules: rules,
            imageUrl: imageUrl,
            unitId: unitId
        )

        let createEventManager = CreateEvent()
        isLoading = true
        errorMessage = nil

        createEventManager.execute(data: newEvent, getMethod: "POST", token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let event):
                    print("Event created successfully: \(event)")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to create event: \(error)")
                }
            }
        }
    }
}


//
//class CreateEventViewModel: ObservableObject {
//    
//    @Published var name: String = ""
//    @Published var description: String = ""
//    @Published var location: String = ""
//    @Published var startDate: String = ""
//    @Published var endDate: String = ""
//    @Published var startTime: String = ""
//    @Published var endTime: String = ""
//    @Published var rules: String = ""
//    @Published var imageUrl: String = "https://lh3.googleusercontent.com/a/ACg8ocJWN9H5pN0ecH3xit1l8PFbf4oE7bVeMTepu3zjnvUKJwynsQ=s96-c"
//    @Published var unitId: String = "66704d5453650896c379d69a"
//
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String? = nil
//    
//    func createEvent(token: String) {
//        let newEvent = CreateEventDTO(
//            name: name,
//            description: description,
//            location: location,
//            startDate: startDate,
//            endDate: endDate,
//            startTime: startTime,
//            endTime: endTime,
//            rules: rules,
//            imageUrl: imageUrl,
//            unitId: unitId
//        )
//        
//        let createEventManager = CreateEvent()
//        isLoading = true
//        errorMessage = nil
//        
//        createEventManager.execute(data: newEvent, getMethod: "POST", token: token) { [weak self] result in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                switch result {
//                case .success(let event):
//                    print("Event created successfully: \(event)")
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                    print("Failed to create event: \(error)")
//                }
//            }
//        }
//    }
//}
