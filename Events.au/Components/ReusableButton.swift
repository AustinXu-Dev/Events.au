//
//  ButtonView.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 11/06/2024.
//

//MARK: - Use this component as a view in button or navigationlink
import SwiftUI
struct ReusableButton: View {
    
    var title: String
    
    var body: some View {
        
            Text(title)
                .foregroundStyle(Theme.primaryTextColor)
                .applyButtonFont()
                .padding(.vertical, Theme.medium)
                .padding(.horizontal, Theme.large)
                .background(
                    RoundedRectangle(cornerRadius: Theme.cornerRadius)
                        .frame(height:Theme.buttonHeight)
                        .foregroundStyle(Theme.tintColor)
                )
        }
        
    }
    
struct ButtonView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ReusableButton(title: "Title")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            ReusableButton(title: "Label")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
