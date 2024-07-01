//
//  PollViewModel.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/30.
//

import Foundation

class PollViewModel: ObservableObject{
    @Published var polls: [PollModel] = [PollModel()]
    @Published var editingPollIndex: Int? = nil
    
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
}

//struct PollModel{
//    let id: String
//    var title: String
//    var options: [String]
//}

class PollModel: ObservableObject, Identifiable, Equatable{
    static func == (lhs: PollModel, rhs: PollModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.pollTitle == rhs.pollTitle &&
               lhs.options == rhs.options &&
               lhs.allowMultipleAnswer == rhs.allowMultipleAnswer
    }
    
    let id = UUID()
    @Published var pollTitle: String = ""
    @Published var options: [String] = ["", ""]
    @Published var allowMultipleAnswer: Bool = false
}
