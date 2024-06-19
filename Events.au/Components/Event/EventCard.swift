//
//  EventCard.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 12/06/2024.
//

import SwiftUI

struct EventCard: View {
    //    @ObservedObject var eventVM : GetAllEventsViewModel
    let event : EventModel
  
    
    var body: some View {
        VStack(alignment:.leading) {
            Image(EventImageMock.image)
                .resizable()
                .scaledToFill()
                .frame(width: Theme.eventImageWidth,height:Theme.eventImageHeight)
            VStack(alignment:.leading,spacing:Theme.headingBodySpacing) {
                Text(event.name)
                    .applyHeadingFont()
                locationAndTime
            }
            .padding(Theme.medium)
        } //end of the whole VStack
        .background(
            RoundedRectangle(cornerRadius: Theme.cornerRadius)
                .foregroundStyle(Theme.backgroundColor)
        )
        .applyThemeDoubleShadow()
    }
}

extension EventCard {
    private var locationAndTime : some View {
        HStack(alignment:.center,spacing:Theme.defaultSpacing) {
            EventParticipants()
            
            
            Spacer()
            Text("\(event.startDate),\(event.startTime)-\(event.endTime)")
                .applyOverlayFont()
            
        }
    }
}

struct EventCard_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            EventCard(event: AllEventsMock.oneEvent)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            
            EventCard(event: AllEventsMock.oneEvent)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
            
        }
    }

}
