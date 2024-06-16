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
    //MARK: have to change this after api integration
    @State var events : [EventModel] = AllEventsMock.events
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(alignment:.center){
                SearchBar(searchText: $searchText, isFiltering: $showingSidebar)
            
           
                categoryScrollView
                
                
            ScrollView(.vertical,showsIndicators: false){
                VStack(alignment:.leading,spacing:Theme.defaultSpacing) {
                    Text("Upcoming Events")
                            .applyLabelFont()
                    ForEach(events,id: \._id){ event in
                        EventCard(event: event)
                        
                    }
                }
            }
        } //end ofVStack
            .padding(.horizontal,Theme.large)
            
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



extension HomeTest {
    private var categoryScrollView : some View {
        VStack(alignment: .leading) {
            Text("Categories")
                .applyLabelFont()
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing:Theme.defaultSpacing) {
                        ForEach(CategoryValue.categories,id:\.id) { category in
                            VStack {
                            Image(category.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width:Theme.categoryImageFrame,height:Theme.categoryImageFrame)
                                .background(
                                    Circle()
                                        .frame(height:64)
                                        .padding(Theme.circlePadding)
                                )
                             
                                .applyThemeDoubleShadow()
                            Text(category.name)
                                    .applyOverlayFont()
                        }
                    }
                }
                
                
            }
            .padding(.vertical,10)
            
        }
    }
}

#Preview {
    HomeTest(path: .constant([]))
}
