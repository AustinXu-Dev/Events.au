//
//  HomeTest.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import SwiftUI

struct HomeTest: View {
    
    @Binding var path: [HomeNavigation]
    
    var body: some View {
        NavigationStack(path: $path){
            ScrollView{
                NavigationLink(value: HomeNavigation.child) {
                    Text("Click me to navigate")
                }
            }
            .navigationDestination(for: HomeNavigation.self) { screen in
                switch screen{
                case .child:
                    ChildView()
                case .secondChild(let person):
                    SecondChildView(person: person)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading) {
                    Image("human_profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    Text("Justin Hollan")
                        .font(Theme.headingFontStyle)
                        
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Image("noti_icon_active")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                }
            }
        }
        .tint(.blue)
        
    }
}

#Preview {
    HomeTest(path: .constant([]))
}
