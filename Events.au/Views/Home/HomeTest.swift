//
//  HomeTest.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import SwiftUI

struct HomeTest: View {
    
    @Binding var path: [HomeNavigation]
    @State var user = UserMock.instance
    @State var isSearching: Bool = false
    @State var showingSidebar: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack(path: $path){
            VStack{
                SearchBar(searchText: $searchText, isFiltering: $showingSidebar)
            }
            //MARK: A scroll view to be integrated here
            ScrollView{
                NavigationLink(value: HomeNavigation.child) {
                    Text("Click me to navigate")
                }
            }
            
            
            .navigationDestination(for: HomeNavigation.self) { screen in
                switch screen{
                case .child:
                    Text("Child")
                case .secondChild(let person):
                    Text("Second child")
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
                    Text(user.user1.firstName)
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
