//
//  Theme.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 06/06/2024.
//


import Foundation
import SwiftUI

struct Theme {
    
    
    // MARK: COLORS
    static let tintColor = Color("TintColor")
    static let backgroundColor = Color("BackgroundColor")
    static let primaryText = Color("PrimaryTextColor")
    static let secondaryText = Color("SecondaryTextColor")
    
    // MARK: Fonts
    static let headingFontSize: CGFloat = 24
    static let headingFontWeight = Font.Weight.bold
    
    static let labelFontSize : CGFloat =  14
    static let labelFontWeight = Font.Weight.medium
    
    static let bodyFontSize : CGFloat =  16
    static let bodyFontWeight = Font.Weight.regular
    
    // MARK: Spacing
    static let defaultSpacing: CGFloat = 10
    static let buttonHeight: CGFloat = 50
    static let textFieldHeight: CGFloat = 40
    
    // MARK: Paddings
    static let padding: CGFloat = 8
    
    // MARK: Shapes
    static let cornerRadius: CGFloat = 10
    
    // MARK: Shadows
    static let shadowColor = Color.gray.opacity(0.2)
    static let shadowRadius: CGFloat = 5
    static let shadowX : CGFloat = 0
    static let shadowY : CGFloat = 5

    // MARK: Icon Sizes
    static let iconSize: CGFloat = 24
    
    // MARK: Image Sizes
    
    static let eventImageWidth : CGFloat = 165
    static let eventImageHeight : CGFloat = 120
    static let vectorImageWidth : CGFloat = 358
    static let vectorImageHeight : CGFloat = 358
    
    
    // MARK: Animation
    static let animationDuration: Double = 0.3
    
    // MARK: Photos
    //add photos here
}



struct ThemeTest {
    //can play around different colors,fonts,etc here and change the initializer
}



