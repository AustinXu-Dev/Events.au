//
//  UpdateEventBasicInfoViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 24/06/2024.
//

import Foundation

class UpdateEventBasicInfoViewModel: ObservableObject {
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

    init(name: String = "", description: String = "", location: String = "", startDate: String = "", endDate: String = "", startTime: String = "", endTime: String = "", rules: String = "", imageUrl: String = "", unitId: String = "66704d5453650896c379d69a") {
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

    func updateEventBasicInfo(eventId: String, token: String) {
        let updatedEvent = CreateEventDTO(
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

        let updateEventManger = UpdateEventBasicInfo(eventId: eventId)
        isLoading = true
        errorMessage = nil

        updateEventManger.execute(data: updatedEvent, getMethod: "PUT", token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let updatedEvent):
//                    print("Event basic info updated successfully: \(updatedEvent)")
                    print("Event basic info updated successfully")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to create event: \(error)")
                }
            }
        }
    }
}
