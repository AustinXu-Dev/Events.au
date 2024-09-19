//
//  UserSoftDeleteViewModel.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 20/09/2024.
//

import Foundation

class UserSoftDeleteViewModel : ObservableObject {
    @Published var loader = false
    @Published var errorMessage: String? = nil
    @Published  var accountIsDeleted : Bool = false


    func deleteAccount(token: String, id: String) {
      loader = true
        let deleteAccountManager = SoftDeleteByUserId(id: id)
        deleteAccountManager.execute(getMethod: "DELETE", token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    print(result)
                    self?.loader = false
                    self?.accountIsDeleted = true
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.loader = false
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
}
