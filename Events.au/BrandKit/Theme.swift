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
    static let circleFaintColor = Color("CircleFaintColor")
    
    // MARK: - FontStyle
    static let overlayFont = "SFPRODISPLAYREGULAR.OTF" //MARK: Have to change this to sf pro display light
    static let labelFont = "SFPRODISPLAYREGULAR.OTF"
    static let headingFont = "SFProDisplay-Semibold.ttf"
    static let bodyFont = "SFPRODISPLAYREGULAR.OTF"
    static let buttonFont = "SFProDisplay-Semibold.ttf"

    
    
    // MARK: - Fonts
    static let overlayFontStyle : Font = .custom(buttonFont,size: 12)
    static let labelFontStyle : Font = .custom(labelFont,size: 20)
    static let headingFontStyle: Font = .custom(headingFont,size: 16)
    static let bodyFontStyle: Font = .custom(bodyFont, size: 16)
    static let buttonFontStyle: Font = .custom(buttonFont,size: 16)

    
    // MARK: - Spacing, Shapes, Widths and Heights
    static let defaultSpacing: CGFloat = 20
    static let textFieldHeadingSpacing : CGFloat = 4
    static let headingBodySpacing : CGFloat = 8
    
    static let buttonHeight : CGFloat = 40
    
    static let textFieldHeight: CGFloat = 40
    
    
    static let eventImageWidth : CGFloat = 361
    static let eventImageHeight : CGFloat = 160
    
    static let circleWidth : CGFloat = 16
    static let circleHeight : CGFloat = 16
    
    // MARK: - Paddings
    
    static let xs : CGFloat = 4
    static let small : CGFloat = 8
    static let medium : CGFloat = 12 //MARK: Use this as a default VPadding
    static let large : CGFloat = 16 //MARK: Use this as a default HPadding and Margin Padding
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
    static let iconWidth: CGFloat = 16
    static let iconHeight: CGFloat = 16
    
    // MARK: - Image Sizes
    
    static let imageWidth : CGFloat = 100
    static let imageHeight : CGFloat = 100
    
    static let vectorImageWidth : CGFloat = 180
    static let vectorImageHeight : CGFloat = 180
    
    // MARK: - Animation
    static let animationDuration: Double = 0.3
    
    // MARK: - Photos & System Images
    static let logo : String = "EventLogo"
    static let logoVector : String = "EventVector"
    static let welcomeText : String = "WelcomeText"
    static let confirmation : String = "Confirmation"
    static let location : String = "location.fill"
    static let clock : String = "clock.fill"
    
        
    
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
