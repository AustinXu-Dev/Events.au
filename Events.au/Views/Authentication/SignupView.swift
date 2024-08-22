//
//  SingUpView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 7/6/2567 BE.
//

import SwiftUI

struct SignupView: View {
    @Binding var path: [AuthNavigation]
    @State private var email: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToSignupForm: Bool = false
    @Environment(\.dismiss) var dismiss
    
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
            
            /*
            VStack(alignment: .leading, spacing: 4) {
                Text(EventAppAutheticationValue.emailAddress)
                    .font(.headline)
                    .padding(.horizontal, 0)
                
                TextField(EventAppAutheticationValue.emailPlaceHolder, text: $email)
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
                Text(EventAppAutheticationValue.password)
                    .font(.headline)
                    .padding(.horizontal, 0)
                
                SecureField(EventAppAutheticationValue.passwordPlaceHolder, text: $newPassword)
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
                Text(EventAppAutheticationValue.password)
                    .font(.headline)
                    .padding(.horizontal, 0)
                
                SecureField(EventAppAutheticationValue.passwordConfrim, text: $newPassword)
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
            
            HStack {
                Spacer()
                
                NavigationLink(value: AuthNavigation.signUpForm) {
                    Text("Next")
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
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.eventDivider)
                
                Text("or")
                    .foregroundColor(Color.eventDivider)
                    .padding(.horizontal, 8)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.eventDivider)
            }
            .frame(width: 361)
            .padding(.vertical, 20)
            
            
            */
            
            
            
//            Button(action: {
//                navigateToSignupForm = true
//            }) {
//                HStack {
//                    Image("google_icon")
//                        .resizable()
//                        .frame(width: 27, height: 28)
//                    
//                    Text(EventAppAutheticationValue.signUpWithGoogle)
//                        .font(.headline) // Adjust font as needed
//                        .foregroundColor(.primary)
//                }
//                .padding()
//                .frame(width: 361, height: 44)
//                .background(Color.clear)
//                .cornerRadius(8)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(Color.gray, lineWidth: 1)
//                )
//            }
            
            NavigationLink(value: AuthNavigation.signUpForm) {
                HStack {
                    Image("google_icon")
                        .resizable()
                        .frame(width: 27, height: 28)
                    
                    Text(EventAppAutheticationValue.signUpWithGoogle)
                        .font(.headline) // Adjust font as needed
                        .foregroundColor(.primary)
                }
                .padding()
                .frame(width: 361, height: 44)
                .background(Color.clear)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            
            HStack {
                Text("Already have an account?")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Button {
                    self.dismiss()
                } label: {
                    Text("Sign In")
                        .font(.system(size: 12))
                        .foregroundColor(Color.eventBackground)
                        .underline()
                }

//                NavigationLink(value: AuthNavigation.signInView) {
//                    Text("Sign In")
//                        .font(.system(size: 12))
//                        .foregroundColor(Color.eventBackground)
//                        .underline()
//                }
            }
            .frame(height: 22)
            .padding(.top, 2)
            
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Sign Up"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
//        .navigationDestination(isPresented: $navigateToSignupForm) {
//            SignupForm()
//        }
    }

    private func signup() {
        guard !email.isEmpty, !newPassword.isEmpty else {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }

        guard isValidEmail(email) else {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }

        alertMessage = "Signed up successfully!"
        showAlert = true
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(path: .constant([]))
    }
}
