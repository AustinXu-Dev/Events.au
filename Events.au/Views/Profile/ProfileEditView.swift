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
    @State private var email: String = "123@gmail.com"
//    @State private var phone: String = "0660297968"
//    @State private var gender: String = "Male"
//    @State private var dateOfBirth: String = "05/05/2001"
    
    
    @StateObject var updateUserViewModel = UpdateUserViewModel()
    let user : UserModel2
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            
            HStack {
                Spacer()
                Image("human_profile")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Image(systemName: "photo.badge.plus")
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                            .padding([.top, .trailing], 5)
                        , alignment: .bottomTrailing
                    )
                Spacer()
            }
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("First Name")
                        .font(.body)
                        .bold()
                    Spacer()
                    TextField("", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 200)
                }
                HStack {
                    Text("Last Name")
                        .font(.body)
                        .bold()
                    Spacer()
                    TextField("", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 200)
                }
                HStack {
                    Text("Email")
                        .font(.body)
                        .bold()
                    Spacer()
                    TextField("", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 200)
                }
//                    HStack {
//                        Text("Phone")
//                            .font(.body)
//                            .bold()
//                        Spacer()
//                        TextField("", text: $phone)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .frame(maxWidth: 200)
//                    }
//                    HStack {
//                        Text("Gender")
//                            .font(.body)
//                            .bold()
//                        Spacer()
//                        TextField("", text: $gender)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .frame(maxWidth: 200)
//                    }
//                    HStack {
//                        Text("Date of Birth")
//                            .font(.body)
//                            .bold()
//                        Spacer()
//                        TextField("", text: $dateOfBirth)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .frame(maxWidth: 200)
//                    }
            }
            .padding()
            .cornerRadius(10)
            .padding(.horizontal)
            
            Button(action: {
                updateUserViewModel.firstName = firstName
                updateUserViewModel.lastName = lastName
                updateUserViewModel.email = email
                if let userId = KeychainManager.shared.keychain.get("appUserId") {
                    updateUserViewModel.updateUser(id: userId, token: TokenManager.share.getToken() ?? "")
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
            
            Spacer()
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(path: .constant([]), selectedTab: .constant(.profile),user: UserMock.instance.user3)
    }
}
