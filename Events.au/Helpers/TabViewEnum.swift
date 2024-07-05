//
//  TabViewEnum.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import Foundation

enum Tab {
    case home, createEvent, profile
}

enum HomeNavigation: Hashable {
    // Dummy enum for testing
    case home
    case eventDetail(EventModel)
    case eventRegistration(EventModel)
    case attendeesList(ParticipantModel)
    case registrationSuccess
}

enum CreateEventNavigation: Hashable{
    case preScreen, fillEventData, createPoll, congrats
}

enum ProfileNavigation: Hashable{
    case profile, setting
}


struct Person: Hashable{
    let name: String
    let lastName: String
}
