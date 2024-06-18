//
//  EventManager.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 18/06/2024.
//

import SwiftUI

struct EventManager: View {
    //MARK: Change Binding to all when you merge with parent view
    @State private var showUpcoming : Bool = false
    @State var ongoingEvents : [EventModel] = EventMock.instacne.allEvents
    
    @State var upcomingEvents : [EventModel] = EventMock.instacne.allEvents
    
    var body: some View {
        VStack(alignment:.center) {
            eventManagerHeader
            
            
            if !showUpcoming {
                VStack(alignment:.center,spacing:Theme.medium) {
                    ForEach(ongoingEvents,id: \._id){ event in
                        EventRow(event: event)
                        
                    }
                }.transition(.move(edge: .leading))
            }
            
            if showUpcoming {
                VStack(alignment:.center,spacing:Theme.medium) {
                    ForEach(upcomingEvents,id: \._id){ event in
                        EventRow(event: event)
                        
                    }
                }.transition(.move(edge: .trailing))
                
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
    
    
    
    
}


struct EventManager_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            EventManager()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            
            EventManager()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
    
}
