//
//  HomeTest.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import SwiftUI

struct HomeTest: View {
    
    @Binding var path: [HomeNavigation]
    @StateObject private var authVM : GoogleAuthenticationViewModel = GoogleAuthenticationViewModel()
    @StateObject private var eventVM : AllEventsViewModel = AllEventsViewModel()
    @StateObject private var profileVM : GetOneUserByIdViewModel = GetOneUserByIdViewModel()
    let unit : UnitModel = UnitMock.instacne.unitA
    @State var isSearching: Bool = false
    @State var showingSidebar: Bool = false
    @State var searchText: String = ""
    @State var selectedCategory : [String] = []
    //MARK: have to change this after api integration
    @State var approvedParticipants : [ParticipantModel] = ParticipantMock.instacne.participants

    
    var body: some View {
        NavigationStack(path: $path){
            VStack(alignment:.leading,spacing:Theme.defaultSpacing){
                SearchBar(searchText: $searchText, isFiltering: $showingSidebar)
                categoryScrollView
                eventsScrollView

            }
            .padding(.horizontal,Theme.large)
            .navigationDestination(for: HomeNavigation.self) { screen in
                switch screen {
                case .child:
                    Text("Child")
                case .secondChild(_):
                    Text("Second child")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Image("human_profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    if let userName = profileVM.userDetail?.firstName {
                        Text(userName)
                            .applyHeadingFont()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
//                    Image("noti_icon_active")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                    //MARK: -This will be the sign out button during the development phase
                    Button {
                        authVM.signOutWithGoogle()
                    } label: {
                        Text("Log Out")
                            .applyOverlayFont()
                            .foregroundStyle(Color.red)
                    }

                }
            }
        }
        .onAppear(perform: {
            eventVM.fetchEvents()
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                profileVM.getOneUserById(id: userId)
            }
        })
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
                        VStack(alignment:.center,spacing:4) {
                            Circle()
                                .frame(height:54)
                                .scaleEffect(selectedCategory.contains(category.id) ? 1.1 : 1)
                                .padding(.vertical,Theme.xs)
                                .foregroundStyle(selectedCategory.contains(category.id) ? Theme.redFaint : Color.white)
                                .applyThemeDoubleShadow()
                                .overlay(
                                    Image(category.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width:Theme.categoryImageFrame,height:Theme.categoryImageFrame)
                                )
                                .applyThemeDoubleShadow()
                            Text(category.name)
                                .applyOverlayFont()
                                .foregroundStyle(selectedCategory.contains(category.id) ? Theme.tintColor : Theme.secondaryTextColor)
                        }
                        .onTapGesture {
                            withAnimation(.spring(duration:0.5)) {
                                if self.selectedCategory.contains(category.id) {
                                    selectedCategory.removeAll(where: {$0 == category.id})
                                } else {
                                    self.selectedCategory.append(category.id)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal,Theme.large)
            }
        }
    }
    
    private var eventsScrollView : some View {
        VStack(alignment:.leading) {
            Text("Upcoming Events")
                .applyLabelFont()
            ScrollView(.vertical,showsIndicators: false){
                VStack(alignment:.leading,spacing:Theme.defaultSpacing) {
                    ForEach(eventVM.events,id: \._id){ event in
                        NavigationLink {
                            EventDetail(event: event, unit:unit, approvedParticipants: approvedParticipants)
                        } label: {
                            EventCard(event: event, approvedParticipants: $approvedParticipants)
                        }
                        .tint(Theme.secondaryTextColor)
                       
                    }
                }
            }
        }
    }
}

#Preview {
    HomeTest(path: .constant([]))
}
