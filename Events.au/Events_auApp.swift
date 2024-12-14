//
//  Events_auApp.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/6.
//

import SwiftUI

@main
struct Events_auApp: App {
   
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    

    @State var homeNavigationStack: [HomeNavigation] = []
    @AppStorage("appState") var isSingIn = false
  @State var deeplinkedEvent: EventModel
  
  @StateObject private var eventVM : GetEventByIdViewModel = GetEventByIdViewModel()
  @StateObject var participantsVM = GetParticipantsByEventIdViewModel()

  
  
    init(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.9960784314, green: 1, blue: 1, alpha: 1)
       UITabBar.appearance().standardAppearance = appearance
       UITabBar.appearance().scrollEdgeAppearance = appearance
            
        }
    
    var body: some Scene {
        
        
        WindowGroup {
            
            Group{
                
                if isSingIn {
//                    NavigationStack {
                    TabScreenView()
                    .onOpenURL { url in
                      handleIncomingLink(url)
                    }
//                    }
//                    ProfileView()
//                    TestView()
                } else {
                    SignInView()
                    .onOpenURL { url in
                      handleIncomingLink(url)
                    }
                }
            }
          
        }
    }
  func handleIncomingLink(_ url: URL) {
        guard let host = url.host, host == "events-au-v2.vercel.app" else { return }
        
        let path = url.path
        if path.starts(with: "/event/") {
            // Extract the event ID and navigate to the detail view
            let eventId = String(path.split(separator: "/").last ?? "")
            navigateToEventDetail(eventId: eventId)
        }
    }

    func navigateToEventDetail(eventId: String) {
        // Logic to navigate to the Event Detail View
        print("Navigating to Event: \(eventId)")
      if isSingIn {
        eventVM.getOneEventById(id: eventId) {
          if let event = eventVM.event {
            homeNavigationStack.append(HomeNavigation.eventDetail(event , ParticipantMock.instance.participants))
          }
        }
        
        
        
        
      }
      
      
      
      
    }
}
