//
//  DropDownMenu.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/23.
//

import SwiftUI

struct DropDownMenu: View {
    
    let options: [UnitModel]
    
//    var menuWdith: CGFloat = 150
    var buttonHeight: CGFloat = Theme.textFieldHeight
    var maxItemDisplayed: Int = 3

    @Binding var menuWidth: CGFloat
    @Binding var selectedOptionIndex: Int
    @Binding var showDropdown: Bool
    
    @State private var scrollPosition: Int?

    var body: some View {
        VStack {

            VStack(spacing: 0) {
                // selected item
                Button(action: {
                    withAnimation {
                        showDropdown.toggle()
                    }
                }, label: {
                    HStack(spacing: nil) {
                        Text(options[selectedOptionIndex].name ?? "VMS")
                            .font(Theme.bodyFontStyle)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees((showDropdown ? -180 : 0)))
                    }
                })
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, minHeight: buttonHeight, alignment: .leading)
                
                // selection menu
                if (showDropdown) {
                    let scrollViewHeight: CGFloat = options.count > maxItemDisplayed ? (buttonHeight*CGFloat(maxItemDisplayed)) : (buttonHeight*CGFloat(options.count))
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(0..<options.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation {
                                        selectedOptionIndex = index
                                        showDropdown.toggle()
                                    }

                                }, label: {
                                    HStack {
                                        Text(options[index].name ?? "VMS")
                                            .font(Theme.bodyFontStyle)
                                        Spacer()
                                        if (index == selectedOptionIndex) {
                                            Image(systemName: "checkmark.circle.fill")

                                        }
                                    }
                                
                                })
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity, minHeight: buttonHeight, alignment: .leading)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $scrollPosition)
                    .scrollDisabled(options.count <= 3)
                    .frame(height: scrollViewHeight)
                    .onAppear {
                        scrollPosition = selectedOptionIndex
                    }
                
                }
                
            }
            .foregroundStyle(Color.black)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            
        }
        .frame(maxWidth: .infinity, minHeight: buttonHeight, alignment: .top)
        .zIndex(100)
    }
}
