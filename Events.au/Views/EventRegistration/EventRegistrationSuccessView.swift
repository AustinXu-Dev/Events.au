//
//  EventRegistrationSuccessView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/24.
//

import SwiftUI

struct EventRegistrationSuccessView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment:.center,spacing:Theme.defaultSpacing){
            Image(Theme.confirmation)
                .resizable()
                .scaledToFill()
                .frame(width:Theme.vectorImageWidth,height:Theme.vectorImageHeight)
            Image(Theme.congratsText)
                .resizable()
                .scaledToFill()
                .frame(width:173,height:35)
            Text("You have successfully\n registered for the event.")
                .multilineTextAlignment(.center)
                .applyLabelFont()
            Button(action: {
//                path.removeLast()
                dismiss()
            }) {
                ReusableButton(title: "Back to Home")
            }
        }
    }
}

#Preview {
    EventRegistrationSuccessView()
}
