//
//  ProfileView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 18/6/2567 BE.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("userRole") private var userRole: String?
    @StateObject var allEventsVM = AllEventsViewModel()
    @StateObject var organizerEventsVM = OrganizerEventsViewModel()
    @State private var showUpcoming : Bool = false
    @StateObject private var profileVM : GetOneUserByIdViewModel = GetOneUserByIdViewModel()
    @State  var selectedUserState : UserState?
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
                    EventManager(events: allEventsVM.events,showUpcoming: $showUpcoming ,allEventsVM : allEventsVM, organizerEventsVM : organizerEventsVM)
                } else if userRole == UserState.organizer.rawValue {
                    EventManager(events: organizerEventsVM.events, showUpcoming:$showUpcoming, allEventsVM : allEventsVM, organizerEventsVM : organizerEventsVM)
                }
            }
            
        }
        .padding(.horizontal,Theme.large)
        .onChange(of: selectedUserState) { userState in
                updateUserRole()
               }
        .onAppear(perform: {
            //get user role from previous state user defaults
            if let role = userRole, let userState = UserState(rawValue: role) {
                userRole = userState.rawValue
                // set the current view user state
                selectedUserState = userState
            }
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                //get user
                profileVM.getOneUserById(id: userId)
            //get all events based on userRole
//            if userRole == UserState.audience.rawValue {
//                self.allEventsVM.fetchEvents()
//            } else {
//                self.organizerEventsVM.fetchEventsByOrganizer(id: userId)
//            }
        }
        })
        
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
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
        guard let userState = selectedUserState else { return }
            roleSwitched = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            roleSwitched = false
            if let userRoleSelection = selectedUserState {
                if userRoleSelection == .audience {
                    self.userRole = UserState.audience.rawValue
                } else if userRoleSelection == .organizer {
                    self.userRole = UserState.organizer.rawValue
                }
                
            }
        }
    }
    
    private var profileDetailButton : some View {
    
        NavigationLink {
            ProfileViewInfo(event: EventMock.instacne.eventA, user: profileVM.userDetail ?? UserMock.instance.user3)
        } label: {
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

