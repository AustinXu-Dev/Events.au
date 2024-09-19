//
//  SettingView.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 19/09/2024.
//

import SwiftUI

struct SettingView: View {
    @State var showSignOutAlert: Bool = false
    @State var showDeleteAccountSheet : Bool = false
    @StateObject private var authVM : GoogleAuthenticationViewModel = GoogleAuthenticationViewModel()
    var body: some View {
        VStack {
            List {
                deleteAccountRow
                logOutRow
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
        .alert(isPresented: $showSignOutAlert) {
            Alert(
                title: Text("Are you sure you want to sign out?"),
                primaryButton: .destructive(Text("OK")) {
                    authVM.signOutWithGoogle()
                },
                secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $showDeleteAccountSheet) {
            DeleteAccountSheetsView()
                .presentationDetents([.height(500), .height(700)])
                .presentationDragIndicator(.automatic)
        }
    }
}

#Preview {
    SettingView()
}

extension SettingView {
    private var deleteAccountRow : some View {
        HStack {
            Text("Delete Account")
                .applyBodyFont()
                .foregroundStyle(Theme.tintColor)
            Spacer()
            Image(systemName: "arrow.right")
                .applyBodyFont()
                .foregroundStyle(Theme.tintColor)
        }
        .background(Color.white)
        .onTapGesture {
            self.showDeleteAccountSheet = true
        }
    }
    
    private var logOutRow : some View {
        HStack {
            Text("Log Out")
                .applyBodyFont()
            Spacer()
            Image(systemName: "arrow.right")
                .applyBodyFont()
        }
        .background(Color.white)
        .onTapGesture {
            self.showSignOutAlert = true
        }
    }
}

/*
 Button {
     showSignOutAlert = true
 } label: {
     Text("Log Out")
         .applyOverlayFont()
         .foregroundStyle(Color.red)
 }
 */
