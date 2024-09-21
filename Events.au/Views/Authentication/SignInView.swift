//
//  SingInView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 7/6/2567 BE.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth
import AuthenticationServices
import CryptoKit

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var nonce: String?
    @State private var authNavigationStack: [AuthNavigation] = []
    @Environment(\.colorScheme) var colorMode

//    @State private var path = NavigationPath()
    @ObservedObject var authViewModel = GoogleAuthenticationViewModel()
    @ObservedObject var signInEmailPassword = SignInEmailPasswordViewModel()
    @ObservedObject var userSignupViewModel = UserSignUpViewModel()
    @ObservedObject var appleSignInViewModel = SignInWithAppleViewModel()
    
    
    var body: some View {
        NavigationStack(path: $authNavigationStack) {
            VStack(spacing:20) {
                Spacer()
                VStack{
                    Image(Theme.logo)
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    HStack(spacing: 0) {
                        Text("A")
                            .foregroundColor(Color.eventBackground)
                        Text("vents")
                            .foregroundColor(Theme.secondaryTextColor)
                    }
                    //                      .applyLabelFont()
                    .font(.system(size: 30))
                    .bold()
                    
                }
                
                
                // email sign in
                
                
                
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
                    
                    SecureField(EventAppAutheticationValue.passwordPlaceHolder, text: $password)
                        .autocapitalization(.none)
                        .padding()
                        .textContentType(.none)
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
                    
                    Button(action: {
                        //                        signup()
                        signInEmailPassword.postSignInFirebaseId(firebaseId: password, email: email)
                    }) {
                        Text("Sign In")
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
                
                // sign in with google
                Button {
                    signInWithGoogle()
                } label: {
                    Image(colorMode == .light ? "continue_with_google_light" : "continue_with_google_dark")
                        .resizable()
                        .frame(width:265,height: 55)
                        .scaledToFill()
                }
             
                // sign in with apple
                SignInWithAppleButton(.continue) { request in
                    // Use the ViewModel to configure the request
                    appleSignInViewModel.configureAppleSignInRequest(request: request)
                } onCompletion: { result in
                    // Handle result using the ViewModel
                    appleSignInViewModel.handleAppleSignInCompletion(result: result)
                }
                .signInWithAppleButtonStyle(colorMode == .dark ? .white : .black)
                .clipShape(.capsule)
                .frame(width: 265, height: 55)

                HStack {
                    Text("Don't have an account?")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    NavigationLink(value: AuthNavigation.signUpView) {
                        Text("Sign Up")
                            .font(.system(size: 12))
                            .foregroundColor(Color.eventBackground)
                            .underline()
                    }
                }
                .frame(height: 22)
                
                Spacer()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Sign In"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationDestination(for: AuthNavigation.self, destination: { value in
                switch value {
                case .signInView:
                    SignInView()
                case .signUpView:
                    SignupView(path: $authNavigationStack)
                case .signUpForm(let email, let pass):
                    SignupForm(path: $authNavigationStack, email: email, pass: pass)
                case .confirmation:
                    ConfirmationView(path: $authNavigationStack)
                }
            })
            
            .navigationDestination(for: Int.self) { value in
                if value == 1{
                    Text("1")
                }
            }
            .navigationBarBackButtonHidden()
            
        }
    }
    
    private func signup() {
        guard !email.isEmpty, !password.isEmpty else {
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
    
    private func signInWithGoogle() {
        authViewModel.signInWithGoogle(presenting: Application_utility.rootViewController) { error, isNewUser in
            if let error = error {
                // Handle the error case, including user cancellation
                if (error as NSError).code == GIDSignInError.canceled.rawValue {
                    // T_T
                } else {
                    self.alertMessage = "Error Signing In with credentials: \(error.localizedDescription)"
                    self.showAlert = true
                }
            }
            if isNewUser {
                // Handle the new user case
                // register a new user with default credentials
                userSignupViewModel.postUser(firstName: authViewModel.firstName ?? "", email: authViewModel.email ?? "", phone: authViewModel.phone ?? 0, fId: authViewModel.fId ?? "") { result in
                    switch result {
                    case .success(let (token, userId)):
                        self.alertMessage = "Welcome to Avents!"
                        self.showAlert = true
                        TokenManager.share.saveTokens(token: token)
                        KeychainManager.shared.keychain.set(userId, forKey: "appUserId")
                        if TokenManager.share.getToken() != nil {
                            UserDefaults.standard.set(true, forKey: "appState")
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.alertMessage = "\(error.localizedDescription)"
                        self.showAlert = true
                    }
                }
            }
            self.alertMessage = authViewModel.alertMessage
            self.showAlert = authViewModel.showAlert
        }
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}



