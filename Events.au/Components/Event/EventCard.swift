//
//  EventCard.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 12/06/2024.
//

import SwiftUI

struct EventCard: View {
    @ObservedObject var participantsVM : GetParticipantsByEventIdViewModel
    
    let event : EventModel
    
    var body: some View {
        VStack(alignment:.leading) {
//            Image(EventImageMock.image)
//                .resizable()
//                .scaledToFill()
//                .frame(width: Theme.eventImageWidth,height:Theme.eventImageHeight)
            
            RemoteImage(url: event.coverImageUrl ?? "no_image")
//                .scaledToFill()
//                .frame(width: Theme.eventImageWidth, height: Theme.eventImageHeight)
            
            VStack(alignment:.leading,spacing:Theme.headingBodySpacing) {
                Text(event.name ?? "")
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
        .onAppear(perform: {
//            if let eventId = event._id {
//                participantsVM.fetchParticipants(id: eventId)
//            }
                  
        })
        
    }
}

extension EventCard {
    private var locationAndTime : some View {
        HStack(alignment:.center,spacing:Theme.defaultSpacing) {
           
            //MARK: - only pass the approved participant to child view
          //  EventParticipants(participants: participantsVM.approvedParticipants, participantStatus: "joining")
            
            
            Spacer()
            if let startDate = event.startDate?.toDate()?.dayWithMonth(), let startTime = event.startTime, let endTime = event.endTime {
                Text("\(String(describing: startDate)), \(String(describing: startTime))-\(String(describing: endTime))")
                    .applyOverlayFont()
            }
        }
    }
}

struct EventCard_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            EventCard(participantsVM: ParticipantMock.instance.participantVM, event: AllEventsMock.oneEvent)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            
            EventCard(participantsVM : ParticipantMock.instance.participantVM,event: AllEventsMock.oneEvent)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
            
        }
    }
    
}
