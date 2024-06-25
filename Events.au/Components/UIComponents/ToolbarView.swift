//
//  ToolbarView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/24.
//

import SwiftUI

struct ToolbarView: View {
    var leftAction: () -> Void
    var rightAction: () -> Void
    var placeholder: String
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                leftAction()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Theme.tintColor)
            })
            Spacer()
            Text(placeholder)
                .font(Theme.labelFontStyle)
            Spacer()
            Button(action: {
                rightAction()
            }, label: {
                Text("Save")
                    .font(Theme.bodyFontStyle)
            })
        }
        .padding(.horizontal, Theme.large)
    }
}
