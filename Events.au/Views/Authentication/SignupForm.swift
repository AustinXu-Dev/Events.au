//
//  SingUpForm.swift
//  Events.au
//
//  Created by Kelvin Gao  on 7/6/2567 BE.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct Faculty: Identifiable {
    let id: Int
    let name: String
}

struct Gender: Identifiable {
    let id: Int
    let type: String
}

struct SignupForm: View {
    @Binding var path: [AuthNavigation]

    @State private var name: String = ""
    @State private var contact: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var selectedFaculty: String = "Select Faculty"
    @State private var selectedGender: String = "Select Gender"
    @State private var selectedUnitName: String = ""
    @State private var selectedUnitId: String = ""
    @State private var isMenuVisible = false
    
    @ObservedObject var allUnitsViewModel = AllUnitsViewModel()
    @ObservedObject var authViewModel = GoogleAuthenticationViewModel()
    @ObservedObject var userSignUpViewModel = UserSignUpViewModel()
  
    @State var errorMessage: String? = ""
    
    @State private var navigateToConfirmation = false
    
    @State private var faculties: [Faculty] = [
        Faculty(id: 1, name: "VMS"),
        Faculty(id: 2, name: "BBA"),
        Faculty(id: 3, name: "LAW"),
    ]
    
    @State private var genders: [Gender] = [
        Gender(id: 1, type: "Male"),
        Gender(id: 2, type: "Female")
    ]
    
    @State private var selectedFacultyName: String = ""
    @State private var selectedFacultyId : Int?
    
    @State private var selectedGenderType: String = ""
    @State private var selectedGenderId : Int?
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image("event_logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 10)
                
                HStack(spacing: 2) {
                    Text("Events.")
                    Text("AU")
                        .foregroundColor(Color.eventBackground)
                }
                .font(.system(size: 20))
                .bold()
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(EventAppAutheticationValue.name)
                    .font(.headline)
                    .padding(.horizontal, 0)
                
                TextField(EventAppAutheticationValue.namePlaceHolder, text: $name)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 361, height: 41.49)
                    .background(Color.clear)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(EventAppAutheticationValue.contact)
                    .font(.headline)
                    .padding(.horizontal, 0)
                
                TextField(EventAppAutheticationValue.contactPlaceHolder, text: $contact)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 361, height: 41.49)
                    .background(Color.clear)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.top, 4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(EventAppAutheticationValue.faculty)
                    .font(.headline)
                    .padding(.horizontal, 0)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("text_color_grey"))
                    .fill(.white)
                    .overlay(
                        Group {
                            HStack {
                                TextField("Select Faculty", text: $selectedUnitName)
                                    .disabled(true)
                                Spacer()
                                Menu {
                                    ForEach(allUnitsViewModel.units, id: \.id){ unit in
                                        Button(unit.name ?? "No Unit Found") {
                                            selectedUnitId = unit.id
                                            selectedUnitName = unit.name ?? ""
                                        }
                                    }
                                } label: {
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding()
//                            .onTapGesture {
//                                allUnitsViewModel.fetchUnits()
//                            }
                        }
                            .tint(Color("text_color_grey"))
                    )
                    .frame(width: 361, height: 41.49)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(EventAppAutheticationValue.gender)
                    .font(.headline)
                    .padding(.horizontal, 0)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("text_color_grey"))
                    .fill(.white)
                    .overlay(
                        Group {
                            HStack {
                                TextField("Select Gender", text: $selectedGenderType)
                                    .disabled(true)
                                Spacer()
                                Menu {
                                    ForEach(genders, id: \.id) { gender in
                                        Button(gender.type) {
                                            selectedGenderId = gender.id
                                            selectedGenderType = gender.type
                                        }
                                    }
                                } label: {
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding()
                        }
                            .tint(Color("text_color_grey"))
                    )
                    .frame(width: 361, height: 41.49)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            
            HStack {
                Spacer()
                Button(action: {
                    //sign up with google
                    signUpWithGoogle()
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .frame(height: 36)
                        .background(Color.eventBackground)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
//            if navigateToConfirmation = true{
//                NavigationLink(value: AuthNavigation.confirmation) {
//                    <#code#>
//                }
//            }
//            NavigationLink(destination: ConfirmationView(), isActive: $navigateToConfirmation) {
//                                EmptyView()
//                            }
            
            Spacer()
        }
//        .alert(isPresented: $showAlert) {
//            Alert(title: Text("Sign Up"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
//                navigateToConfirmation = true
//            }
//            )
//            
//            
//        }
        .alert("Singn Up", isPresented: $showAlert) {
            NavigationLink(value: AuthNavigation.confirmation) {
                Text("Ok")
            }
            
        } message: {
            Text(alertMessage)
        }
        .onAppear{
            allUnitsViewModel.fetchUnits()
        }
    }
    
    private func signUpWithGoogle() {
        guard let phoneInt = Int(contact) else {
            showAlert = true
            alertMessage = "Invalid phone number."
            return
        }
        
        authViewModel.signUpWithGoogle(presenting: Application_utility.rootViewController) { error, isNewUser in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                }
                if isNewUser{
                    //post here
                    userSignUpViewModel.postUser(firstName: self.name, email: authViewModel.email ?? "", phone: phoneInt, fId: authViewModel.fId ?? "", unitId: self.selectedUnitId) { result in
                        switch result {
                        case .success:
                            self.alertMessage = "User registration successful"
                            navigateToConfirmation = true
                            authViewModel.signOutWithGoogle()
                        case .failure(let error):
                            self.alertMessage = "Registration failed \(error)"
                            authViewModel.signOutWithGoogle()
                        }
                        self.showAlert = true
                    }
                } else {
                    //handle error
                }
            }
        }
    }
}
//
//struct SignupForm_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupForm()
//    }
//}
