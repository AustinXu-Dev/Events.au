//
//  EventDetail.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 22/06/2024.
//

import SwiftUI

struct EventDetail: View {
    let event : EventModel
    let unit : UnitModel
    let approvedParticipants : [ParticipantModel]
    @Environment(\.colorScheme) var colorScheme
    @State private var isParagraph : Bool = false
    
    var body: some View {
        
        ScrollView(.vertical,showsIndicators: false) {
            VStack(alignment:.leading,spacing: Theme.headingBodySpacing) {
                eventImage
                details
                Divider()
                    .foregroundStyle(Theme.tintColor)
            }
            VStack(alignment:.center) {
                dateAndLocation
            }
            VStack(alignment:.leading) {
                attendees
                registerButton
                    .padding(.vertical,8)
            }
        }
        .padding(.horizontal,Theme.large)
        
        
        
    }
}


extension EventDetail {
    private var eventImage : some View {
        Image(Theme.eventImage)
            .resizable()
            .frame(width: Theme.eventImageWidth,height: Theme.eventImageHeight)
            .scaledToFill()
    }
    private var details : some View {
        VStack(alignment:.leading,spacing: Theme.headingBodySpacing) {
            Text(event.name)
                .applyLabelFont()
            Text(unit.name)
                .applyMediumFont()
                .foregroundColor(Theme.tintColor)
            
            VStack(alignment:.leading,spacing:Theme.xs) {
                Text(event.description)
                    .applyBodyFont()
                    .lineLimit(isParagraph ? .max : 6)
                Button {
                    withAnimation(.default) {
                        self.isParagraph.toggle()
                    }
                } label: {
                    Text(isParagraph ? "see less" : "read more")
                        .foregroundStyle(Theme.tintColor)
                        .applyOverlayFont()
                }
                
            }
        }
    }
    
    private var dateAndLocation : some View {
        HStack(spacing:65) {
            VStack(alignment:.center) {
                Text("\(Date().formatDateOnly()) - \(Date().formatDateOnly())")
                    .applyHeadingFont()
                    .foregroundStyle(Theme.tintColor)
                Text("\(Date().formatMonthOnly())")
                    .applyHeadingFont()
                    .foregroundStyle(Theme.secondaryTextColor)
                
            }
            .padding(8)
            .background(RoundedRectangle(cornerRadius: Theme.cornerRadius))
            .foregroundStyle(Color.white)
            .applyThemeDoubleShadow()
            
            VStack(alignment:.leading) {
                HStack(spacing:Theme.headingBodySpacing) {
                    Image(systemName: Theme.clock)
                        .resizable()
                        .frame(width: Theme.iconWidth,height: Theme.iconHeight)
                        .scaledToFill()
                    Text("\(event.startTime)-\(event.endTime)")
                        .applyMediumFont()
                }
                
                HStack(spacing:Theme.headingBodySpacing) {
                    Image(colorScheme == .light ? Theme.locationLight : Theme.locationDark)
                        .resizable()
                        .frame(width: Theme.iconWidth,height: Theme.iconHeight)
                        .scaledToFill()
                    Text(event.location)
                        .applyMediumFont()
                }
            }
        }
        .padding(8)
    }
    
    
    private var attendees : some View {
        HStack(spacing:Theme.xs) {
            Text("Attending: ")
                .applyHeadingFont()
            EventParticipants(participants: approvedParticipants, participantStatus: "")
                .applyHeadingFont()
        }
    }
    
    private var registerButton : some View {
        Button {
            print("Hello nigga")
        } label: {
            Text("Register Now")
                .applyButtonFont()
                .foregroundStyle(Theme.primaryTextColor)
                .padding(.horizontal,Theme.large)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(RoundedRectangle(cornerRadius: Theme.cornerRadius))
                .foregroundStyle(Theme.tintColor)
            
            
        }
    }
    
}


#Preview {
    NavigationStack {
        EventDetail(event: EventMock.instacne.eventA, unit: UnitMock.instacne.unitA, approvedParticipants: ParticipantMock.instacne.participants)
    }
    .padding(.horizontal,Theme.large)
    
}
