//
//  CustomTabBarAppearance.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 20/09/2024.
//

import Foundation
import UIKit
import SwiftUI

struct CustomTabBarAppearance: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let appearance = UITabBarAppearance()
        
        // Configure appearance for light mode
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white // Light mode color
        
        // Apply appearance for dark mode
        if UITraitCollection.current.userInterfaceStyle == .dark {
            appearance.backgroundColor = UIColor.black.withAlphaComponent(0.45) // Dark mode color
        }
        
        // Set the appearance for the tab bar
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
