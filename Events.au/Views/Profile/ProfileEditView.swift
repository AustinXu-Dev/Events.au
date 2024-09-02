//
//  AdminProfileEditView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 17/6/2567 BE.
//

import SwiftUI

struct ProfileEditView: View {
    
    @Binding var path: [ProfileNavigation]
    @Binding var selectedTab: Tab
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @Environment(\.dismiss) var dismiss
    
    @StateObject var updateUserViewModel = UpdateUserViewModel()
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    let user: UserModel2
    
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            
            HStack {
                Spacer()
//                Image("human_profile")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .clipShape(Circle())
//                    .overlay(
//                        Image(systemName: "photo.badge.plus")
//                            .foregroundColor(.white)
//                            .padding(6)
//                            .background(Color.black.opacity(0.7))
//                            .clipShape(Circle())
//                            .padding([.top, .trailing], 5)
//                        , alignment: .bottomTrailing
//                    )
                UserProfileDetailAvatar(user: user)
//                if let imageUrl = FirebaseManager.shared.auth.currentUser?.photoURL {
//                    RemoteProfleEdit(url: "\(imageUrl)")
//                }
                Spacer()
            }
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("First Name")
                        .font(.body)
                        .bold()
                    Spacer()
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 200)
                }
                HStack {
                    Text("Last Name")
                        .font(.body)
                        .bold()
                    Spacer()
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 200)
                }
//                HStack {
//                    Text("Email")
//                        .font(.body)
//                        .bold()
//                    Spacer()
//                    TextField("", text: $email)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .frame(maxWidth: 200)
//                }
            }
            .padding()
            .cornerRadius(10)
            .padding(.horizontal)
            
            Button(action: {
                if validateFields() {
                    updateUserViewModel.firstName = firstName
                    updateUserViewModel.lastName = lastName
//                    updateUserViewModel.email = email
                    if let userId = KeychainManager.shared.keychain.get("appUserId") {
                        updateUserViewModel.updateUser(id: userId, token: TokenManager.share.getToken() ?? "")
                    }
                    self.dismiss()
                }
            }) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color.eventBackground)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Information Required"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            Spacer()
        }
    }
    
    private func validateFields() -> Bool {
        // Validate first name
        if firstName.isEmpty {
            alertMessage = "Please enter your first name."
            showAlert = true
            return false
        }
        
        // Validate last name
        if lastName.isEmpty {
            alertMessage = "Please enter your last name."
            showAlert = true
            return false
        }
        
        // Validate email
//        if !email.hasSuffix("@gmail.com") {
//            alertMessage = "Please enter a valid Gmail address (must end with @gmail.com)."
//            showAlert = true
//            return false
//        }
        
        return true
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(path: .constant([]), selectedTab: .constant(.profile), user: UserMock.instance.user3)
    }
}
