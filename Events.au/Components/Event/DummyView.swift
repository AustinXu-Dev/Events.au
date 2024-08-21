//
//  DummyView.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 20/08/2024.
//

import SwiftUI

struct DummyView: View {
    @Binding var profilePath: [ProfileNavigation]
    @Binding var selectedTab: Tab
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                print("Dummy: ", profilePath)
            }
        Button {
            profilePath = []
            selectedTab = .home
        } label: {
            Text("Mg shine la ou sote")
        }

    }
}

//#Preview {
//    DummyView()
//}
