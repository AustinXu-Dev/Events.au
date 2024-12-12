//
//  TabViewEnum.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import Foundation
import SwiftUI

enum Tab {
    case home, createEvent, profile
}

enum HomeNavigation: Hashable {
    // Dummy enum for testing
    case home
    case eventDetail(EventModel,[ParticipantModel])
    case eventRegistration(EventModel)
    case attendeesList([ParticipantModel])
    case registrationSuccess
    case reusableProfile(ParticipantModel)
  case profileInfo(UserModel2)

}

enum CreateEventNavigation: Hashable{
    case preScreen, fillEventData, createPoll, congrats
}

enum ProfileNavigation: Hashable{
    case profile
  case reusableProfile(ParticipantModel)
  case participantProfileInfo(UserModel2)
    case profileViewInfo(UserModel2)
    case eventDetail(EventModel,[ParticipantModel])
  case attendeesList([ParticipantModel])
    case profileEditView(UserModel2)
    case profileEventDetail
    case orgEventDetailPreEdit(EventModel, UnitModel)
    case orgEventDetailEditView(EventModel, UnitModel)
    case settingView
}

enum AuthNavigation : Hashable {
    case signUpView
    case signInView
    case signUpForm(email: String, password: String)
    case confirmation
}

struct Person: Hashable{
    let name: String
    let lastName: String
}

