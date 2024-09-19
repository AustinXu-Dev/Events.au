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
    static let greenFaint = Color("GreenFaint")
    static let redFaint = Color("RedFaint")
    static let backgroundColorPink = Color("BackgroundColorPink")
    
    
    static let pendingEventColor = "PendingEventStatus"
    static let approvedEventColor = "ApprovedEventStatus"
    
    // MARK: - FontStyle
    static let overlayFont = "SFProDisplayLight"
    static let labelFont = "SFProDisplay-Semibold"
    static let headingFont = "SFProDisplay-Semibold"
    static let bodyFont = "SFPRODISPLAYREGULAR"
    static let buttonFont = "SFProDisplay-Semibold"
    static let profileNameFont = "SFProDisplay-Semibold"
    static let mediumFont = "SFPRODISPLAYMEDIUM"

    
    
    // MARK: - Fonts ( Just add .apply_FontStyle as view modifier)
    static let overlayFontStyle : Font = .custom(overlayFont,size: 12)
    static let labelFontStyle : Font = .custom(labelFont,size: 20)
    static let headingFontStyle: Font = .custom(headingFont,size: 16)
    static let bodyFontStyle: Font = .custom(bodyFont, size: 16)
    static let buttonFontStyle: Font = .custom(buttonFont,size: 16)
    static let profileNameStyle : Font = .custom(profileNameFont, size: 32)
    static let mediumFontStyle : Font = .custom(mediumFont, size: 12)


    
    // MARK: - Spacing, Shapes, Widths and Heights
    static let defaultSpacing: CGFloat = 20
    static let textFieldHeadingSpacing : CGFloat = 4
    static let headingBodySpacing : CGFloat = 8
    
    static let buttonHeight : CGFloat = 40
    
    static let textFieldHeight: CGFloat = 40
    static let textFieldWidth : CGFloat = 261
    
    static let eventImageWidth : CGFloat = 361
    static let eventImageHeight : CGFloat = 160
    
    static let circleWidth : CGFloat = 16
    static let circleHeight : CGFloat = 16
    
    static let participantSquareImage : CGFloat = 64
    static let participantRectWidth : CGFloat = 361
    static let participantRectHeight : CGFloat = 72
    
    static let categoryImageFrame : CGFloat = 26

    
    
    // MARK: - Paddings
    
    static let xs : CGFloat = 4
    static let small : CGFloat = 8
    static let medium : CGFloat = 12 //MARK: Use this as a default VPadding
    static let large : CGFloat = 16 //MARK: Use this as a default HPadding and Margin Padding
    static let xl : CGFloat = 24
    static let xxl : CGFloat = 32
    static let xxxl : CGFloat = 156
    
    static let circlePadding : CGFloat = 20
    
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
    static let logo : String = "AventLogo"
    static let logoVector : String = "EventVector"
    static let welcomeText : String = "WelcomeText"
    static let confirmation : String = "Confirmation"
    static let location : String = "location.fill"
    static let clock : String = "clock.fill"
    static let calendar : String = "calendar"
    static let congratsText: String = "CongratsText"
    static let eventauText: String = "EventAUText"
    static let eventauTextDarkMode: String = "EventAUText_DarkMode"
    static let createEventImage: String = "CreateEventImage"
    static let createEventImageDarkMode : String = "CreateEventImage_DarkMode"

    
    // MARK: - Icon Names
    static let gamingIcon : String = "gaming_icon"
    static let techIcon : String = "tech_icon"
    static let businessIcon : String = "business_icon"
    static let entertainmentIcon : String = "entertainment_icon"
    static let academyIcon : String = "academy_icon"
    static let participantIcon : String = "participant_icon"
    
    static let lightModePencil : String = "pencil_icon_lightmode"
    static let darkModePencil : String = "pencil_icon_darkmode"
    static let clickedPencil : String = "pencil_icon_clicked"
    
    static let locationLight : String = "location_light"
    static let locationDark : String = "location_dark"
    
    static let eventImage : String = "EventImagePreview"
    
    static let noEventVector : String = "no_event_vector"
    static let profileEditButton : String = "profile_edit_button"
    
    static let settingLightIcon = "settings_lightmode"
    static let settingDarkIcon = "settings_darkmode"
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
