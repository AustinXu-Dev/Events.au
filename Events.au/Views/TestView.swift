//
//  TestView.swift
//  Events.au
//
//  Created by Akito Daiki on 22/06/2024.


import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

struct TestView: View {
    @StateObject private var viewModel = CreateEventViewModel()
    @StateObject private var authVM = GoogleAuthenticationViewModel()
    @StateObject private var getOneUserVM = GetOneUserByIdViewModel()
    @StateObject private var getParticipantsByEventId = GetParticipantsByEventIdViewModel()
    
    @State private var shouldShowImagePicker = false
    @State var image: UIImage?
    
    //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NmU5ODk5MjQzZjQ2NGUzNzAyMmQ0YyIsImlhdCI6MTcyMTY1NDY4NSwiZXhwIjoxNzIxOTEzODg1fQ.MUr7yi5C07-R5QuBEfdoLXlo6zp0rawRu9IubpQ0F0s
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

//                    TextField("Image URL", text: $viewModel.imageUrl)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
                    
                    HStack(spacing: 16) {
                        Button {
                            shouldShowImagePicker.toggle()
                        } label: {
                            Image(systemName: "paperclip")
                                .font(.system(size: 24))
                                .foregroundColor(Color(.darkGray))
                        }
                        
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                        } else {
                            Text("No image selected")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    
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

//                    Button("Create Event") {
//                        viewModel.createEvent(token: TokenManager.share.getToken() ?? "")
//                    }
                    Button("Create Event") {
                        let uid = Auth.auth().currentUser?.uid ?? ""
                        let email = Auth.auth().currentUser?.email ?? ""
                        
                        if let image = image {
                            viewModel.uploadImage(image) { result in
                                switch result {
                                case .success(let imageUrl):
                                    viewModel.storeImageUrl(imageUrl: imageUrl, uid: uid, email: email) { result in
                                        switch result {
                                        case .success:
                                            // Retrieve the imageUrl from Firestore
                                            viewModel.retrieveImageUrl(uid: uid) { result in
                                                switch result {
                                                case .success(let storedImageUrl):
                                                    // Update the viewModel's imageUrl with the stored value
                                                    viewModel.coverImageUrl = storedImageUrl
                                                    // Create the event
                                                    print(viewModel.name, viewModel.description, viewModel.startDate, viewModel.endDate, viewModel.startTime, viewModel.endTime, viewModel.rules, viewModel.coverImageUrl, viewModel.unitId)
                                                    if !viewModel.coverImageUrl.isEmpty{
                                                        viewModel.createEvent(token: TokenManager.share.getToken() ?? "")
                                                    }
                                                case .failure(let error):
                                                    print("Failed to retrieve image URL: \(error.localizedDescription)")
                                                }
                                            }
                                        case .failure(let error):
                                            print("Failed to store image URL: \(error.localizedDescription)")
                                        }
                                    }
                                case .failure(let error):
                                    print("Failed to upload image: \(error.localizedDescription)")
                                }
                            }
                        } else {
                            print("No image selected")
                        }
                    }
                    .padding()
                    .disabled(viewModel.isLoading)
                }
            }
//            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
//                ImagePicker(image: $image)
//                    .ignoresSafeArea()
//            }
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
