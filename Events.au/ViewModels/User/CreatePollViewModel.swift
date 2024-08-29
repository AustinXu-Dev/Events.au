//
//  CreatePollViewModel.swift
//  Events.au
//
//  Created by Austin Xu on 2024/7/23.
//

import Foundation
import SwiftUI

class CreatePollViewModel: ObservableObject {
    @Published var polls: [PollDTO] = [PollDTO()]
    @Published var editingPollIndex: Int? = nil
   
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func toggleEditing(for index: Int) {
        if editingPollIndex == index {
            editingPollIndex = nil
        } else {
            editingPollIndex = index
        }
    }
    
    func deletePoll(for index: Int){
        polls.remove(at: index)
    }

    func createPoll(token: String) {
        let polls = self.polls

        let createPollManager = UserCreatePoll()
        isLoading = true
        errorMessage = nil
        
        polls.forEach { i in
            let poll = PollDTOFinal(eventId: "669f2ef7b9629d6616f55ce0", title: i.title, multi_select: i.multi_select, options: i.options)
//            i.eventId = "669f2ef7b9629d6616f55ce0"
            createPollManager.execute(data: poll, getMethod: "POST", token: token) { [weak self] result in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch result {
                    case .success(let event):
                        break;
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}
