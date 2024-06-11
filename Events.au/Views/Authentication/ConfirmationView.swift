//
//  ConfirmationView.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 10/06/2024.
//

import SwiftUI

struct ConfirmationView: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(alignment:.center,spacing:Theme.defaultSpacing){
            Image(Theme.confirmation)
                .resizable()
                .scaledToFill()
                .frame(width:Theme.vectorImageWidth,height:Theme.vectorImageHeight)
            Image(Theme.welcomeText)
                .resizable()
                .scaledToFill()
                .frame(width:173,height:35)
            Text("Signup successful.\nPlease signin again.")
                .multilineTextAlignment(.center)
                .applyLabelFont()
            Button(action: {
//                path.removeLast()
            }) {
                ReusableButton(title: "Sign In")
            }
        }
        
        
        
        
        
        
    }
}

#Preview {
    NavigationStack {
        ConfirmationView(path: .constant(NavigationPath()) )
    }
}
