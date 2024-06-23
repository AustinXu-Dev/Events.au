//
//  TestView.swift
//  Events.au
//
//  Created by Akito Daiki on 22/06/2024.
//

import SwiftUI

struct TestView: View {
    @StateObject private var viewModel = CreateEventViewModel()
    @StateObject private var authVM = GoogleAuthenticationViewModel()
    @StateObject private var getOneUserVM = GetOneUserByIdViewModel()

    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    TextField("Event Name", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Description", text: $viewModel.description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Location", text: $viewModel.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Start Date", text: $viewModel.startDate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("End Date", text: $viewModel.endDate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Start Time", text: $viewModel.startTime)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("End Time", text: $viewModel.endTime)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Rules", text: $viewModel.rules)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Image URL", text: $viewModel.imageUrl)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Unit ID", text: $viewModel.unitId)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    if viewModel.isLoading {
                        ProgressView()
                    }

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }

                    Button("Create Event") {
                        viewModel.createEvent(token: TokenManager.share.getToken() ?? "")
//                        if let userId = KeychainManager.shared.keychain.get("appUserId") {
//                            getOneUserVM.getOneUserById(userId: userId)
//                        }
//                        getOneUserVM.getOneUserById(id: KeychainManager.shared.keychain.get("appUserId") ?? "")
//                        print(KeychainManager.shared.keychain.get("appUserId") ?? "")
                    }
                    .padding()
                    .disabled(viewModel.isLoading)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        authVM.signOutWithGoogle()
                    }) {
                        Image(systemName: "door.left.hand.open")
                    }
                }
                ToolbarItem{
                    Button(action: {
                        print(TokenManager.share.getToken() ?? "")
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    TestView()
}
