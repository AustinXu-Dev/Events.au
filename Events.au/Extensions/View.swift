//
//  View.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 10/06/2024.
//

import Foundation
import SwiftUI

extension View {
    func applyThemeDoubleShadow() -> some View {
        self.modifier(ShadowModifier(shadow1Color: Theme.innerShadowColor,
                                     shadow1Radius: Theme.innerShadowRadius,
                                     shadow1X: Theme.innerShadowX,
                                     shadow1Y: Theme.innerShadowY,
                                     shadow2Color: Theme.outerShadowColor,
                                     shadow2Radius: Theme.outerShadowRadius,
                                     shadow2X: Theme.outerShadowX,
                                     shadow2Y: Theme.outerShadowY))
    }
    
    
    
    
    // MARK: Use this for large labels

    func applyLabelFont() -> some View {
           self.modifier(FontModifier(style: Theme.labelFontStyle))
       }
 
    // MARK: Use this for heading above body text
    func applyHeadingFont() -> some View {
           self.modifier(FontModifier(style: Theme.headingFontStyle))
       }
    
    // MARK: Use this for default body text

    func applyBodyFont() -> some View {
           self.modifier(FontModifier(style: Theme.bodyFontStyle))
       }
    
    // MARK: Use this for text inside a button
    func applyButtonFont() -> some View {
           self.modifier(FontModifier(style: Theme.buttonFontStyle))
       }
    
    func applyOverlayFont() -> some View {
        self.modifier(FontModifier(style: Theme.overlayFontStyle))
    }
    

    
    
}
