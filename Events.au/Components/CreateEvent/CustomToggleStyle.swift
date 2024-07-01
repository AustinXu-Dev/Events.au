//
//  CustomToggleStyle.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/30.
//

import Foundation
import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Rectangle()
            .foregroundColor(configuration.isOn ? .green : .gray)
            .frame(width: 51, height: 31, alignment: .center)
            .overlay(
                Circle()
                    .foregroundColor(.white)
                    .padding(.all, 3)
                    .overlay(
                        Image(systemName: configuration.isOn ? "checkmark" : "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(Font.title.weight(.black))
                            .frame(width: 8, height: 8, alignment: .center)
                            .foregroundColor(configuration.isOn ? .green : .gray)
                    )
                    .offset(x: configuration.isOn ? 11 : -11, y: 0)
                    .animation(Animation.linear(duration: 0.1), value: configuration.isOn)
                    
            ).cornerRadius(20)
            .onTapGesture { configuration.isOn.toggle() }
        
    }
    
}
