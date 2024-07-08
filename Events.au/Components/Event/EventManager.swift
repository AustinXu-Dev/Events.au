//
//  EventManager.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 18/06/2024.
//

import SwiftUI

struct EventManager: View {
    
    let events : [EventModel]
    
    @Binding var showUpcoming : Bool
   
    
    
    var body: some View {
        VStack(alignment:.center) {
            eventManagerHeader
            if !showUpcoming {
                ScrollView(.vertical,showsIndicators: false) {
                    VStack(alignment:.center,spacing:Theme.medium) {
                        if events.count != 0 {
                            ForEach(events,id: \._id){ event in
                                if event.startDate?.toDate() == Date() {
                                    EventRow(event: event)
                                }
                                
                            }
                        } else {
                            noEventsView
                            .offset(y:100)
                        }
                    }.transition(.move(edge: .leading))
                }
            }
            if showUpcoming {
                ScrollView(.vertical,showsIndicators: false) {
                    VStack(alignment:.center,spacing:Theme.medium) {
                        if events.count != 0 {
                            ForEach(events,id: \._id){ event in
                                EventRow(event: event)
                            }
                        } else {
                            noEventsView
                                .offset(y:100)
                        }
                    }.transition(.move(edge: .trailing))
                }
            }
        }
        Spacer(minLength: 0)
    }
    
    
}

extension EventManager {
    private var eventManagerHeader : some View {
        HStack {
            VStack(alignment:.center) {
                Text("Ongoing")
                    .applyLabelFont()
                    .onTapGesture {
                        withAnimation {
                            self.showUpcoming = false
                        }
                    }
                Rectangle()
                    .foregroundStyle(Theme.tintColor)
                    .frame(width:150,height:3)
                    .opacity(showUpcoming ? 0 : 1)
            }
            Spacer(minLength: 0)
            VStack(alignment:.center) {
                Text("Upcoming")
                    .applyLabelFont()
                    .onTapGesture {
                        withAnimation {
                            self.showUpcoming = true
                        }
                    }
                Rectangle()
                    .foregroundStyle(Theme.tintColor)
                    .frame(width:150,height:3)
                    .opacity(showUpcoming ? 1 : 0)
            }
            
        }
    }
    private var noEventsView : some View {
        VStack(alignment:.center,spacing:Theme.defaultSpacing) {
            Image(systemName: "xmark.circle")
                .font(.system(size: 100))
                .foregroundStyle(Color.gray.opacity(0.55))
                .applyThemeDoubleShadow()
            Text("There is no events \nin the meantime")
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .applyLabelFont()
                .foregroundStyle(Theme.secondaryTextColor)
        }
    }
}


struct EventManager_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            EventManager(events: EventMock.instacne.allEvents, showUpcoming: .constant(false))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            
            EventManager(events:EventMock.instacne.allEvents,showUpcoming: .constant(false))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
