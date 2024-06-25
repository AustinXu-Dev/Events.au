//
//  TextFieldWithIcon.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/24.
//

import SwiftUI

struct TextFieldWithIcon: View {
    
    var placeHolder: String
    @Binding var selectedPlaceholder: String
    var image: String
    
    var body: some View {
        HStack {
            TextField(placeHolder, text: $selectedPlaceholder)
                .padding(8)
                .frame(height: Theme.textFieldHeight)
                .font(Theme.bodyFontStyle)
            Image(image) // Replace with your desired icon
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
        .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.3), lineWidth: 1))
    }
}

struct TextWithIcon: View {
    
    var placeHolder: String
    var image: String
    
    var body: some View {
        HStack{
            Text(placeHolder)
                .font(Theme.bodyFontStyle)
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: Theme.textFieldHeight, alignment: .leading)
            Spacer()
            Image(image) // Replace with your desired icon
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.3), lineWidth: 1))
    }
}


