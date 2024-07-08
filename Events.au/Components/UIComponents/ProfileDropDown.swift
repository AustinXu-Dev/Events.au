//
//  ProfileDropDown.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 08/07/2024.
//

import SwiftUI

struct ProfileDropDown: View {
    let prompt : String
    @State private var isExpanded : Bool = false
    @Binding var selectedCategory : UserState?
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Text(selectedCategory?.rawValue ?? prompt)
                    .foregroundStyle(Theme.tintColor)
                    .applyLabelFont()
                Spacer()
                Image(systemName: "chevron.down")
                    .font(.subheadline)
                    .rotationEffect(.degrees(isExpanded ? -180 : 0))
            }
            .background(Theme.backgroundColor)
            .padding(.horizontal)
            .frame(height:40)
            .onTapGesture(perform: {
                withAnimation(.snappy) {
                    self.isExpanded.toggle()
                }
            })
            
            if isExpanded {
                VStack {
                    ForEach(UserState.allCases,id:\.self) { option in
                        HStack {
                            Text(option.rawValue)
                                .foregroundStyle(Theme.secondaryTextColor)
                                .applyLabelFont()
                            Spacer()
                            if selectedCategory?.rawValue ?? UserState.audience.rawValue == option.rawValue {
                                Image(systemName: "checkmark")
                                    .font(.subheadline)
                                
                            }
                        }
                        .frame(height:40)
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                self.selectedCategory? = option
                                self.isExpanded.toggle()
                            }
                        }
                    }
                }
                .transition(.move(edge: .bottom))
            }
          
          
        }
        .background(Theme.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius))
        .applyThemeDoubleShadow()
        .frame(width:175)
    }
}

//#Preview {
//    ProfileDropDown(prompt: "Select", selectedCategory: .constant("Audience"))
//        .padding()
//}
