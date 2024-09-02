//
//  GetAdminByIdViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 24/06/2024.
//

import Foundation

class GetAdminByIdViewModel: ObservableObject {
    
    @Published var adminData: AdminModel? = nil
    @Published var errorMessage: String? = nil
    
    func getAdminById(id: String) {
        errorMessage = nil
        let getAdmin = GetAdminById(id: id)
        getAdmin.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let adminData):
                    self.adminData = adminData.message
                case .failure(let error):
                    self.errorMessage = "Failed to get user detail by id: \(error.localizedDescription)"
                }
            }
        }
    }
}
