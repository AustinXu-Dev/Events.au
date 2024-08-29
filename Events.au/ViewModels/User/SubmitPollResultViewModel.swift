//
//  SubmitPollResultViewModel.swift
//  Events.au
//
//  Created by Austin Xu on 2024/7/24.
//

import Foundation

class SubmitPollResultViewModel: ObservableObject{
    @Published var pollResults: [PollResultDTO] = []
    
    func submitResult(token: String){
        let submitPollManager = UserSubmitPollResult()
        
        pollResults.forEach { pollResult in
            submitPollManager.execute(data: pollResult, getMethod: "POST", token: token) { result in
                DispatchQueue.main.async {
                    switch result{
                    case .success( _):
                        break;
                    case .failure(let error):
                        break;
                    }
                }
            }
        }
        
    }
}
