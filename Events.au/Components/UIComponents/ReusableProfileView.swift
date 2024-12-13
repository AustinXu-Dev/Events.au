//
//  ReusableProfileView.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 10/12/2024.
//

import SwiftUI

struct ReusableProfileView: View {
  @Binding var path : [HomeNavigation]
  @Binding var profilePath: [ProfileNavigation]
  @Binding var selectedTab: Tab
  var participant: ParticipantModel
  @Environment(\.colorScheme) var colorMode
  var isComingFromProfile: Bool
  
  var body: some View {
      VStack(alignment:.leading,spacing: Theme.defaultSpacing) {
        headerProfile
          .padding(.horizontal,Theme.large)
        if let userName = participant.userId?.firstName {
          Text(userName)
            .applyProfileNameFont()
            .padding(.horizontal,Theme.xxl)
        }
        
        profileDetailButton
          .padding(.horizontal,Theme.xxl)
        
      
      }
      .frame(maxHeight: .infinity,alignment: .topLeading)
     
    
    
  }
}

extension ReusableProfileView {
  private var headerProfile : some View {
    ZStack(alignment:.bottomLeading){
      Image("wallpaper")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width:393,height: 186)
      ParticipantProfileAvatar(participant: participant)
        .padding(.leading,Theme.large)
        .padding(.bottom,Theme.large)
      
      
      
    }
    
    
  }
  
  private var profileDetailButton : some View {
    
    if !isComingFromProfile {
      NavigationLink(value: HomeNavigation.profileInfo(participant.userId ?? UserMock.instance.user3)) {
        Text("Profile Details")
          .applyButtonFont()
          .frame(maxWidth: .infinity)
          .foregroundColor(.white)
      }
      .padding(.vertical,Theme.medium)
      .background(Theme.tintColor)
      .cornerRadius(Theme.cornerRadius)
    } else {
      NavigationLink(value: ProfileNavigation.participantProfileInfo(participant.userId ?? UserMock.instance.user3)) {
        Text("Profile Details")
          .applyButtonFont()
          .frame(maxWidth: .infinity)
          .foregroundColor(.white)
      }
      .padding(.vertical,Theme.medium)
      .background(Theme.tintColor)
      .cornerRadius(Theme.cornerRadius)
    }
    
    
    
    
    
  }
  
}


#Preview {
  ReusableProfileView(path: .constant([]), profilePath: .constant([]), selectedTab: .constant(.home), participant: ParticipantMock.instance.participantA, isComingFromProfile: false)
}
