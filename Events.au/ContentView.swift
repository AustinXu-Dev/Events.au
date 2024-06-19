//
//  ContentView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/6.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var tokenManager: TokenManager
    @State var homeNavigationStack: [HomeNavigation] = []
    
    var body: some View {
        VStack(spacing:Theme.defaultSpacing) {
            if tokenManager.isTokenValid {
                HomeTest(path: $homeNavigationStack)
            } else {
                SignInView()
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
