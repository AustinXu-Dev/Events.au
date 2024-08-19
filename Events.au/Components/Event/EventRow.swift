//
//  EventRow.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 17/06/2024.
//

import SwiftUI
//MARK: - This is a micro component for EventManager
struct EventRow: View {
    //MARK: This can either be pending or approved events
    let event : EventModel
    //MARK: reteriving userRole to check where to display event status or event joining status
    @AppStorage("userRole") private var userRole: String?
    @ObservedObject var eventParticipants : GetParticipantsByEventIdViewModel
    let participant : ParticipantModel

    var body: some View {
        ZStack {
        RoundedRectangle(cornerRadius: Theme.cornerRadius)
            .frame(width: Theme.participantRectWidth,height: Theme.participantRectHeight)
            .foregroundStyle(Theme.backgroundColor)
            .applyThemeDoubleShadow()
            HStack(alignment:.center,spacing:Theme.medium) {
                Image(EventImageMock.image)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius))
                .frame(width:Theme.participantSquareImage,height:Theme.participantSquareImage)
                .scaledToFit()
                VStack(alignment:.leading,spacing:Theme.medium) {
                    Text(event.name ?? "")
                    .applyHeadingFont()
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    if let startDate = event.startDate, let startTime = event.startTime, let endTime = event.endTime {
                        Text("\(startDate), \(startTime)-\(endTime)")
                            .applyOverlayFont()
                    }
            }
                Spacer()
                VStack {
                    Text(userRole == UserState.audience.rawValue ?
                         participant.status ?? "" :
                         event.status ?? "")
                        .applyOverlayFont()
                        .padding(.horizontal,8)
                        .padding(.vertical,2)
                        .background(
                            EventStatus.instance.colorHandler(status: userRole == UserState.audience.rawValue ?
                                                              participant.status ?? "" :
                                                              event.status ?? "")
                        )
                        .cornerRadius(Theme.xs)
                        .offset(y:-20)
                }
        }
        .padding(Theme.xs)
    }
        .onAppear {
            //pass event id
            eventParticipants.fetchParticipants(id: event.id)
        }
        
    }
}

struct EventRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            EventRow(event: EventMock.instacne.eventA, eventParticipants: GetParticipantsByEventIdViewModel(), participant: ParticipantMock.instacne.participantA)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            EventRow(event: EventMock.instacne.eventA, eventParticipants: GetParticipantsByEventIdViewModel(), participant: ParticipantMock.instacne.participantA)                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}

