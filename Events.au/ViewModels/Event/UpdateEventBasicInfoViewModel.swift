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
    @Published var coverImageUrl: String
    @Published var unitId: String

    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var showAlert: Bool = false
    

    init(name: String = "", description: String = "", location: String = "", startDate: String = "", endDate: String = "", startTime: String = "", endTime: String = "", rules: String = "", coverImageUrl: String = "", unitId: String = "") {
        self.name = name
        self.description = description
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        self.startTime = startTime
        self.endTime = endTime
        self.rules = rules
        self.coverImageUrl = coverImageUrl
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
            coverImageUrl: coverImageUrl,
            unitId: unitId
        )

        let updateEventManger = UpdateEventBasicInfo(eventId: eventId)
        isLoading = true
        showAlert = true
        errorMessage = nil

        updateEventManger.execute(data: updatedEvent, getMethod: "PUT", token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(_):
                    break;
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
