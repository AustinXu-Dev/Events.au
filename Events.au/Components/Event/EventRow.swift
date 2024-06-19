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
                    Text(event.name)
                    .applyHeadingFont()
                    Text("\(event.startDate),\(event.startTime)-\(event.endTime)")
                    .applyOverlayFont()
            }
                Spacer()
                VStack {
                    Text(event.status)
                        .applyOverlayFont()
                        .padding(.horizontal,8)
                        .padding(.vertical,2)
                        .background(
                            EventStatus.instance.colorHandler(status: event.status)
                        )
                        .cornerRadius(Theme.xs)
                        .offset(y:-20)
                }
        }
        .padding(Theme.xs)
        }
    }
}

struct EventRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            EventRow(event: EventMock.instacne.eventA)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            EventRow(event: EventMock.instacne.eventA)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}

