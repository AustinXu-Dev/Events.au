//
//  LogOutSheetsView.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 20/09/2024.
//

import SwiftUI

struct DeleteAccountSheetsView: View {
    @StateObject private var deleteAccountVM = UserSoftDeleteViewModel()
    @StateObject private var authVM =  GoogleAuthenticationViewModel()
    @Environment(\.dismiss) var dismissSheet
    var body: some View {
        ZStack {
            if deleteAccountVM.loader {
                ProgressView()
                    .foregroundStyle(Theme.tintColor)
            }
        VStack(alignment:.leading,spacing: Theme.defaultSpacing) {
            Text("⚠️ Account Deletion Confirmation ⚠️")
                .bold()
            Text("You are about to permanently delete your account. This action cannot be undone, and you will lose access to all your data, including any saved preferences, activity history, and linked accounts.Are you sure you want to proceed?")
                .applyBodyFont()
            Text("Important Notes")
                .applyBodyFont()
            Text("• You will no longer have access to Avents.\n• If you change your mind, please contact support before confirming.")
                .applyBodyFont()
            
            Button {
                if let userId = KeychainManager.shared.keychain.get("appUserId"), let token = KeychainManager.shared.keychain.get("userToken") {
                    deleteAccountVM.deleteAccount(token: token, id: userId)
                }
            } label: {
                ReusableButton(title: "Proceed to Delete")
            }
            .frame(alignment: .center)
            
            
            Spacer()

            
        }
        .padding(.vertical,Theme.xl)
        .padding(.horizontal,Theme.large)
        }    .alert(isPresented: $deleteAccountVM.accountIsDeleted) {
        Alert(
            title: Text("Your Account is Deleted"),
            message: Text("We hope to see you soon!"),
            dismissButton: .default(Text("Log Out")) {
                authVM.signOutWithGoogle()
            }
        )
    }
     
        
    }
}

#Preview {
    DeleteAccountSheetsView()
}

