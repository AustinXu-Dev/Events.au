//
//  GetPollsByEventIdViewModel.swift
//  Events.au
//
//  Created by Austin Xu on 2024/7/24.
//

import Foundation

class GetPollsByEventIdViewModel: ObservableObject {
    @Published var polls: [PollModel] = []
    @Published var loader: Bool = false
    @Published var errorMessage: String? = nil
    
    func getPollsByEventId(id: String){
        errorMessage = nil
        let getPolls = GetPollsByEventId(id: id)
        getPolls.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let pollResult):
                    self.polls = pollResult.message
                    print(pollResult.message)
                case .failure(let error):
                    self.errorMessage = "Failed to get poll for the event"
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
