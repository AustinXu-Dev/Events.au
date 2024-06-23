//
//  GetOneUserViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 23/06/2024.
//

import Foundation

class GetOneUserViewModel: ObservableObject {
    
    @Published var userDetail: UserModel
    @Published var errorMessage: String? = nil
    
    func getOneUserById(userId: String) {
        errorMessage = nil
        let getOneUser = GetUserById(userId: userId)
        getOneUser.execute(token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userDetailData):
                    self.userDetail = userDetailData
                case .failure(let error):
                    self.errorMessage = "Failed to get user detail by id."
                }
            }
        }
    }
}
