//
//  GetOneUserViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 23/06/2024.
//

import Foundation

class GetOneUserByIdViewModel: ObservableObject {
    
    @Published var userDetail: UserModel2? = nil
    @Published var errorMessage: String? = nil
    
    func getOneUserById(id: String) {
        errorMessage = nil
        let getOneUser = GetUserById(id: id)
        getOneUser.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userDetailData):
                    self.userDetail = userDetailData.message
//                    print("UserDetail: \(userDetailData.message)")
                case .failure(let error):
                    self.errorMessage = "Failed to get user detail by id."
                    print(error.localizedDescription)
                }
            }
        }
    }
}
