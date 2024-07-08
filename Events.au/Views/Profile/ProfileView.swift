//
//  ProfileView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 18/6/2567 BE.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("userRole") private var userRole: String = UserState.audience.rawValue
    @StateObject var allEventsVM = AllEventsViewModel()
    @State private var showUpcoming : Bool = false
    @StateObject private var profileVM : GetOneUserByIdViewModel = GetOneUserByIdViewModel()
    @State  var selectedUserState : UserState? = .audience
    @State private var roleSwitched = false
    
    @State var isLoading : Bool = false
    @State var textLoader : Bool = false
    
    var body: some View {
        VStack(spacing:Theme.defaultSpacing) {
            
            if roleSwitched {
                ReusableLoader(loaderText: "Switching Roles", isLoading: $isLoading, textLoader:$textLoader)
            } else {
            VStack(alignment:.center) {
                headerProfile
                if let userName = profileVM.userDetail?.firstName {
                    Text(userName)
                        .applyProfileNameFont()
                }
                HStack {
                    accountSelectionRow
                    Spacer()
                    profileDetailButton
                }
            }
            
                if userRole == UserState.audience.rawValue {
                    EventManager(events: allEventsVM.events,showUpcoming: $showUpcoming)
                } else {
                    EventManager(events: allEventsVM.events, showUpcoming:$showUpcoming )
                }
            }
            
        }
        .padding(.horizontal,Theme.large)
        .onChange(of: selectedUserState) { userState in
                   updateUserRole()
            print(userState ?? "")
            print("App storage userRole is \(userRole)")
               }
        .onAppear(perform: {
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                profileVM.getOneUserById(id: userId)
                self.allEventsVM.fetchEvents()
            }
        })
        
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    
    private var headerProfile : some View {
        VStack {
            Image("wallpaper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:393,height: 186)
                .overlay(
                    Image("human_profile")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: Theme.imageWidth, height: Theme.imageHeight)
                )
            
        }
        
        
    }
    
    
    
    private var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Image("wallpaper")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            VStack(alignment:.leading) {
                Image("human_profile")
                    .resizable()
                    .frame(width: Theme.imageWidth, height: Theme.imageHeight,alignment: .leading)
                    .clipShape(Circle())
                    .offset(x:-16,y:-24)
            }
        }
    }
    
    private var accountSelectionRow : some View {
        VStack {
            if let user = profileVM.userDetail {
                if user.isOrganizer {
                    ProfileDropDown(prompt: "Select", selectedCategory: $selectedUserState )
                }
            }
            
        }
    }
    
    private func updateUserRole() {
        roleSwitched = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            roleSwitched = false
            if let userRoleSelection = selectedUserState {
                if userRoleSelection.rawValue == UserState.audience.rawValue {
                    self.userRole = UserState.organizer.rawValue
                } else if userRoleSelection.rawValue == UserState.organizer.rawValue {
                    self.userRole = UserState.audience.rawValue
                }
                
            }
        }
    }
    
    private var profileDetailButton : some View {
        Button(action: {
            print("Button clicked")
        }) {
            HStack {
                Image(systemName: "pencil")
                Text("Profile Detail")
                    .applyButtonFont()
            }
            .foregroundColor(.white)
            
        }
        .padding(.vertical,Theme.medium)
        .padding(.horizontal,Theme.large)
        
        .frame(maxWidth: .infinity)
        
//        .frame(width: 174.5)
        .background(Theme.tintColor)
        .cornerRadius(Theme.cornerRadius)
    }
    
}

