//
//  GetEventById.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 15/12/2024.
//

import Foundation

@MainActor
class GetEventByIdViewModel: ObservableObject {
  @Published var event: EventModel? = nil
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  
  func getOneEventById(id: String,completion: @escaping () -> ()) {
    DispatchQueue.main.async {
      self.isLoading = true
    }
    let getOneEvent = GetEventById(eventId: id)
      getOneEvent.execute(getMethod: "GET", token: nil) { [weak self] result in
        self?.isLoading = false
          DispatchQueue.main.async {
              switch result {
              case .success(let event):
                DispatchQueue.main.async {
                  self?.event = event.message
                  completion()
                }
              case .failure(let error):
                DispatchQueue.main.async {
                  self?.errorMessage = "Failed to get user detail by id: \(error.localizedDescription)"
                  completion()
                }
              }
          }
      }
  }
}

