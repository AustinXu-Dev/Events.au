//
//  UpdateUserViewModel.swift
//  Events.au
//
//  Created by Akito Daiki on 24/06/2024.
//

import Foundation

class UpdateUserViewModel: ObservableObject {
    @Published var firstName: String
    @Published var lastName: String
//    @Published var email: String

    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    init(firstName: String = "", lastName: String = ""/*, email: String = ""*/) {
        self.firstName = firstName
        self.lastName = lastName
//        self.email = email
    }

    func updateUser(id: String, token: String) {
        let userNewInfo = UpdateUserDTO(
            firstName: firstName,
            lastName: lastName
//            email: email
        )

        let updateUser = UpdateUserById(id: id)
        isLoading = true
        errorMessage = nil

        updateUser.execute(data: userNewInfo, getMethod: "PUT", token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    print("User update created successfully: \(user)")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to create event: \(error.localizedDescription)")
                }
            }
        }
    }
}
