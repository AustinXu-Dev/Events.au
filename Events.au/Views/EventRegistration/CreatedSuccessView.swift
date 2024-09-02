//
//  CreatedSuccessView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 1/7/2567 BE.
//

import SwiftUI

struct CreatedSuccessView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("Confirmation")
                .resizable()
                .scaledToFit()
                .frame(width: 191, height: 194)
            
            Image("CongratsText")
                .resizable()
                .scaledToFit()
                .frame(width: 224.54, height: 34.88)
            
            Text("You have successfully \n registered for the event.")
                .font(.system(size: 16))
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .padding([.top, .bottom], 10)
            
                        
            Button(action: {
            
            }) {
                Text("Back to Home")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 131, height: 40)
                    .background(Color.eventBackground)
                    .cornerRadius(10)
                
            }
            .padding(.bottom, 40)
            
            Spacer()

        }
    }
}

struct CreatedSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        CreatedSuccessView()
    }
}
