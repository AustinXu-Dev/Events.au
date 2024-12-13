//
//  ProfileView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 18/6/2567 BE.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct ProfileView: View {
    @Binding var path : [HomeNavigation]
    @Binding var profilePath: [ProfileNavigation]
    @Binding var selectedTab: Tab
    
    @AppStorage("userRole") private var userRole: String?
    @StateObject var participantEventsVM = ParticipantEventsViewModel()
    @StateObject var organizerEventsVM = OrganizerEventsViewModel()
    @StateObject var participantVM : GetParticipantsByEventIdViewModel = GetParticipantsByEventIdViewModel()
    @State private var showUpcoming : Bool = false
    @EnvironmentObject private var profileVM : GetOneUserByIdViewModel 
    @State  var selectedUserState : UserState?
    @State private var roleSwitched = false
    //this is for switching off the animation for the first time onAppear
    @State private var isInitialSetup: Bool = true
    @State var isLoading : Bool = false
    @State var textLoader : Bool = false
    @Environment(\.colorScheme) var colorMode
    
    var body: some View {
        NavigationStack {
            VStack(spacing:Theme.defaultSpacing) {
                
                if roleSwitched {
                    ReusableLoader(loaderText: "Switching Roles", isLoading: $isLoading, textLoader:$textLoader)
                } else {
                    ScrollView(.vertical,showsIndicators: false){
                        VStack(alignment:.leading,spacing: Theme.defaultSpacing) {
                            headerProfile
                            if let userName = profileVM.userDetail?.firstName {
                                HStack {
                                    Text(userName)
                                        .applyProfileNameFont()
                                    Spacer()
                                    if let user = profileVM.userDetail {
                                        // MARK: - dispaly this row if user isn't organizer
                                        if let userIsOrganizer = user.isOrganizer {
                                            if !userIsOrganizer {
                                                if let userModel = profileVM.userDetail{
                                                    NavigationLink(value: ProfileNavigation.profileViewInfo(userModel)) {
                                                        Image(Theme.profileEditButton)
                                                            .frame(width:8,height:8)
                                                            .fixedSize(horizontal: true, vertical: false)
                                                            .padding(.trailing,Theme.large)
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal,Theme.large)
                                
                            }
                            HStack {
                                if let user = profileVM.userDetail, let userIsOrganizer = user.isOrganizer {
                                    //MARK: -dispaly this if user is organizer
                                    if userIsOrganizer {
                                        accountSelectionRow
                                        Spacer()
                                        profileDetailButton
                                    }
                                }
                            }
                            .padding(.horizontal,Theme.large)
                        }
                        
                        if userRole == UserState.audience.rawValue {
                            
                            EventManager(showUpcoming: $showUpcoming, participantEventsVM: participantEventsVM, organizerEventsVM: organizerEventsVM, profileVM: profileVM, approvedParticipantsVM: participantVM, path: $path, profilePath: $profilePath, selectedTab: $selectedTab)
                                .padding(.top,12)
                        } else if userRole == UserState.organizer.rawValue {
                            EventManager(showUpcoming: $showUpcoming, participantEventsVM: participantEventsVM, organizerEventsVM: organizerEventsVM, profileVM: profileVM, approvedParticipantsVM: participantVM, path: $path, profilePath: $profilePath, selectedTab: $selectedTab)
                                .padding(.top,12)
                        }
                    }
                    .padding(.horizontal,Theme.large)
                }
            }
            .padding(.horizontal,Theme.large)
            //                Spacer(minLength: 0)
            .navigationDestination(for: ProfileNavigation.self) { value in
                switch value {
                case .profileViewInfo(let userModel):
                    ProfileViewInfo(path: $profilePath, selectedTab: $selectedTab, user: userModel,participantEventsVM: participantEventsVM,organizerEventsVM: organizerEventsVM, profileVM: profileVM)
                case .profileEditView(let userModel):
                    ProfileEditView(path: $profilePath, selectedTab: $selectedTab, user: userModel)
                case .profileEventDetail:
                    Text("Event Detail")
                case .eventDetail(let event, _):
                    if let user = profileVM.userDetail {
                      EventDetail(user: user, event: event, path: $path, profilePath: $profilePath, selectedTab: $selectedTab, participantsVM: participantVM, approvedParticipants: participantVM.approvedParticipants, comingFromProfileTab: true)
                    }
                case .orgEventDetailPreEdit(let event, let unit):
                    EventPreEditView(event: event, unit: unit, path: $path, profilePath: $profilePath, participantVM: participantVM, selectedTab: $selectedTab)
                case .orgEventDetailEditView(let event, let unit):
                    EventDetailsEditView(event: event, unit: unit, path: $path, profilePath: $profilePath, selectedTab: $selectedTab)
                case .settingView:
                    SettingView()
                case .reusableProfile(let participant):
                  ReusableProfileView(path: $path, profilePath: $profilePath, selectedTab: $selectedTab, participant: participant, isComingFromProfile: true)
                case .participantProfileInfo(let user):
                  ReusableProfileInfoView(path: $path, selectedTab: $selectedTab, user: user)
                case .attendeesList(let participants):
                  AttendeesListView(path:$path, profilePath:$profilePath, selectedTab:$selectedTab, approvedParticipants: participants, comingFromProfileTab: true)
                default:
                    Text("Navigation Crashed")
                }
            }
        }
        .onAppear(perform: {
            if userRole == nil {
                userRole = UserState.audience.rawValue
            }
            //get user role from previous state user defaults
            if let role = userRole, let userState = UserState(rawValue: role) {
                userRole = userState.rawValue
                // set the current view user state
                selectedUserState = userState
            }
            
        })
        .onChange(of: selectedUserState) { _,_ in
            
            updateUserRole()
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                profileVM.getOneUserById(id: userId)
            }
                    
            }
        .refreshable {
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                profileVM.getOneUserById(id: userId)
            }
        }
        
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(path: .constant([]), profilePath: .constant([]), selectedTab: .constant(.profile))
        }
    }
}

extension ProfileView {
    
    private var headerProfile : some View {
        ZStack(alignment:.bottomLeading){
            Image("wallpaper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:393,height: 186)
                .overlay(
                    NavigationLink(value: ProfileNavigation.settingView) {
                        ZStack {
                            Circle()
                                .frame(width:30,height:30)
                                .foregroundColor(colorMode == .light ? .white : .gray)
                                .applyThemeDoubleShadow()
                                .padding()
                            Image(colorMode == .light ? Theme.settingLightIcon : Theme.settingDarkIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15,height:15)
                        }
                    }
                    ,alignment: .topTrailing)
            
            
            if let user = profileVM.userDetail {
                UserProfileAvatar(user: user)
                    .padding(.horizontal,Theme.large)
                    .padding(.bottom,Theme.large)
            }
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
            ProfileDropDown(prompt: "Select", selectedCategory: $selectedUserState)
        }
    }
    
    private func updateUserRole() {
        //        guard let userState = selectedUserState else { return }
        //for first time launching the app, the loader shouldn't show up in profile tab
        if !isInitialSetup {
            roleSwitched = true
        }
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
        // then, this will be toggled for later profile changing
        isInitialSetup = false
    }
    
    private var profileDetailButton : some View {
        
        NavigationLink(value: ProfileNavigation.profileViewInfo(profileVM.userDetail ?? UserMock.instance.user3)) {
            HStack {
                Image(systemName: "pencil")
                Text("Profile Detail")
                    .applyButtonFont()
            }
            .foregroundColor(.white)
        }
        .padding(.vertical,Theme.medium)
        .frame(width:175)
        .background(Theme.tintColor)
        .cornerRadius(Theme.cornerRadius)
    }
    
}
