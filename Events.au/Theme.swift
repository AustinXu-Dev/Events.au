//
//  Theme.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 06/06/2024.
//


import Foundation
import SwiftUI

struct Theme {
    
    
    // MARK: - COLORS
    static let tintColor = Color("TintColor")
    static let backgroundColor = Color("BackgroundColor")
    static let primaryTextColor = Color("PrimaryTextColor")
    static let secondaryTextColor = Color("SecondaryTextColor")
    
    // MARK: - FontStyle
    // need to import
    static let labelFont = "SF Pro Display"
    static let bodyFont = "Inter"
    
    
    // MARK: - Fonts
    
    static let labelFontStyle: Font = .system(size: 24, weight: Font.Weight.semibold)
    static let headingFontStyle: Font = .system(size: 16, weight: Font.Weight.semibold)
    static let bodyFontStyle: Font = .system(size: 16, weight: Font.Weight.regular)
    static let buttonFontStyle: Font = .system(size: 15, weight: Font.Weight.semibold)

    
    // MARK: - Spacing, Widths and Heights
    static let defaultSpacing: CGFloat = 20
    
    static let buttonHeight : CGFloat = 40
    
    static let textFieldHeight: CGFloat = 40
    static let textFieldSpacing : CGFloat = 4
    
    // MARK: - Paddings
    
    static let xs : CGFloat = 4
    static let small : CGFloat = 8
    static let medium : CGFloat = 12 //MARK: Use this as a default VPadding
    static let large : CGFloat = 16 //MARK: Use this as a default HPadding
    static let xl : CGFloat = 24
    static let xxl : CGFloat = 32
    static let xxxl : CGFloat = 156
    
    
    
    // MARK: - Shapes
    static let cornerRadius: CGFloat = 8
    
    // MARK: - Shadows
    
    // MARK:  Inner Shadow
    static let innerShadowColor = Color.black.opacity(0.08)
    static let innerShadowRadius: CGFloat = 2
    static let innerShadowX : CGFloat = 0
    static let innerShadowY : CGFloat = 0
    
    // MARK:  Outer Shadow
    
    static let outerShadowColor = Color.black.opacity(0.05)
    static let outerShadowRadius: CGFloat = 15
    static let outerShadowX : CGFloat = 0
    static let outerShadowY : CGFloat = 4
    
    
    
    // MARK: - Icon Sizes
    static let iconSize: CGFloat = 24
    
    // MARK: - Image Sizes
    
    static let imageWidth : CGFloat = 100
    static let imageHeight : CGFloat = 100
    
    static let vectorImageWidth : CGFloat = 180
    static let vectorImageHeight : CGFloat = 180
    
    // MARK: - Animation
    static let animationDuration: Double = 0.3
    
    // MARK: - Photos
    static let logo : String = "EventLogo"
    static let logoVector : String = "EventVector"
    static let welcomeText : String = "WelcomeText"
    static let confirmation : String = "Confirmation"
    
        
    
}

struct ShadowModifier: ViewModifier {
    
    let shadow1Color: Color
    let shadow1Radius: CGFloat
    let shadow1X: CGFloat
    let shadow1Y: CGFloat
    
    let shadow2Color: Color
    let shadow2Radius: CGFloat
    let shadow2X: CGFloat
    let shadow2Y: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: shadow1Color, radius: shadow1Radius, x: shadow1X, y: shadow1Y)
            .shadow(color: shadow2Color, radius: shadow2Radius, x: shadow2X, y: shadow2Y)

    }
    
    
    
}

struct FontModifier: ViewModifier {
    let style: Font

    func body(content: Content) -> some View {
        content
            .font(style)
    }
}



