//
//  EventDetail.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 22/06/2024.
//

import SwiftUI

struct EventDetail: View {
    let user : UserModel2
    let event : EventModel
    @Binding var path: [HomeNavigation]
    @Binding var profilePath : [ProfileNavigation]
    @Binding var selectedTab: Tab
    @StateObject  var eventUnitsVM : GetUnitsByEventViewModel = GetUnitsByEventViewModel()
    @ObservedObject var participantsVM : GetParticipantsByEventIdViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isParagraph : Bool = false
    let approvedParticipants : [ParticipantModel]
    @State var isAllowedToJoin: Bool = false
    @State var showAlert: Bool = false
    @State private var currentUserId: String? = nil
    @State private var isUserParticipant: Bool = false
    @State private var isUserPending: Bool = false
    
    var comingFromProfileTab: Bool
    
    
    var body: some View {
        
        ZStack {
            colorScheme == .light ? Color.white : Color.black
            ScrollView(.vertical,showsIndicators: false) {
                if eventUnitsVM.loader && participantsVM.isLoading {
                    ProgressView()
                } else {
                    VStack(alignment:.leading,spacing: Theme.headingBodySpacing) {
                        if let eventImage = event.coverImageUrl {
                            RemoteImage(url:eventImage)
                        }
                        details
                        Divider()
                            .foregroundStyle(Theme.tintColor)
                    }
                    VStack(alignment:.center) {
                        dateAndLocation
                    }
                    VStack(alignment:.leading) {
                        if approvedParticipants.count > 0 {
                            if !comingFromProfileTab {
                                NavigationLink(value: HomeNavigation.attendeesList(approvedParticipants)) {
                                    attendeesBox
                                }
                            } else {
                                NavigationLink(value: ProfileNavigation.attendeesList(approvedParticipants)) {
                                    attendeesBox
                                }
                            }
                        }
                    }

                    if let userId = currentUserId {
                        if participantsVM.isLoading {
                            ProgressView()
                        } else {
                            if participantsVM.participantPending(userId: userId) {
                                pendingButton
                                    .padding(.vertical, 8)
                            } else if participantsVM.participantExists(userId: userId) {
                                alreadyRegisteredButton
                                    .padding(.vertical, 8)
                            } else if participantsVM.participantRejected(userId: userId){
//                                rejectedMessage
                            } else {
                                registerButton
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal,Theme.large)
        }
        .onAppear(perform: {
            if let eventId = event._id {
                eventUnitsVM.getUnitsByEvent(id: eventId)
                participantsVM.fetchParticipants(id: eventId)
            }
            
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                currentUserId = userId
            }
        })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Complete your profile setup first."),
                primaryButton: .default(Text("OK").foregroundStyle(.blue)) {
                    selectedTab = .profile
                },
                secondaryButton: .cancel(){
                    path = []
                }
            )
        }
    }
}


extension EventDetail {
    private var details : some View {
        VStack(alignment:.leading,spacing: Theme.headingBodySpacing) {
            Text(event.name ?? "")
                .applyLabelFont()
            HStack {
                ForEach(eventUnitsVM.eventUnits,id:\._id){ eventUnit in
                    Text(eventUnit.unitId.name ?? "Unknown Faculty")
                        .applyMediumFont()
                        .foregroundStyle(Theme.tintColor)
                }
            }
            VStack(alignment:.leading,spacing:Theme.xs) {
                Text(event.description ?? "This event has no description.")
                    .applyBodyFont()
                    .lineLimit(isParagraph ? .max : 3)
                
                if let eventDescription = event.description {
                    if eventDescription.count >= 129 {
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
        }
    }
    
    private var dateAndLocation : some View {
        HStack(spacing:65) {
            VStack(alignment:.center) {
                if let startDate = event.startDate?.toDate()?.formatDateOnly(), let endDate = event.endDate?.toDate()?.formatDateOnly(), let eventMonth = event.startDate?.toDate()?.formatMonthOnly() {
                    Text("\(startDate) - \(endDate)")
                        .applyHeadingFont()
                        .foregroundStyle(Theme.tintColor)
                    Text("\(eventMonth)")
                        .applyHeadingFont()
                        .foregroundStyle(Theme.tintColor)
                }
            }
            .padding(8)
            .background(RoundedRectangle(cornerRadius: Theme.cornerRadius))
            .foregroundStyle(Color.white)
            .applyThemeDoubleShadow()
            
            VStack(alignment:.leading,spacing:Theme.small) {
                if let startTime = event.startTime, let endTime = event.endTime {
                    HStack(spacing:Theme.headingBodySpacing) {
                        Image(systemName: Theme.clock)
                            .resizable()
                            .frame(width: Theme.iconWidth,height: 18)
                            .scaledToFill()
                        Text("\(startTime)-\(endTime)")
                            .applyMediumFont()
                    }
                }
                
                HStack(spacing:Theme.headingBodySpacing) {
                    if let location = event.location {
                        Image(colorScheme == .light ? Theme.locationLight : Theme.locationDark)
                            .resizable()
                            .frame(width: Theme.iconWidth,height: 18)
                            .scaledToFill()
                        Text(location)
                            .applyMediumFont()
                    }
                }
            }
        }
        .padding(8)
    }
    
    
    private var attendees : some View {
        
        VStack(alignment:.leading,spacing: Theme.small) {
            
            Text("Participants")
                .applyHeadingFont()
            EventParticipants(participants:approvedParticipants, participantStatus: "joining")
                .applyHeadingFont()
            
        }
    }
    
    private var attendeesBox: some View {
        RoundedRectangle(cornerRadius: Theme.cornerRadius)
            .foregroundStyle(Theme.backgroundColor)
            .frame(maxWidth: .infinity,alignment: .leading)
            .frame(height: 80)
            .applyThemeDoubleShadow()
            .overlay (
                HStack {
                    attendees
                        .tint(Theme.secondaryTextColor)
                    Spacer()
                }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
    }
    
    private var registerButton : some View {
        Button {
            if let phNo = user.phone{
                if phNo < 0 {
                    isAllowedToJoin = false
                    showAlert = true
                } else {
                    isAllowedToJoin = true
                    path.append(HomeNavigation.eventRegistration(event))
                }
            }
            
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
    
    private var pendingButton: some View {
        Button(action: {
            
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                Text("Request Pending")
                    .applyButtonFont()
                    .foregroundStyle(Theme.primaryTextColor)
                    .padding(.horizontal, Theme.large)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
            }
        }
        .disabled(true)
    }
    
    private var alreadyRegisteredButton : some View {
        Button(action: {
            
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                Text("Already Registered")
                    .applyButtonFont()
                    .foregroundStyle(Theme.primaryTextColor)
                    .padding(.horizontal, Theme.large)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
            }
        }
        .disabled(true)
    }
    
//    private var rejectedMessage: some View {
//        HStack {
//            Image(systemName: "xmark.circle.fill")
//                .foregroundColor(.red)
//            Text("You were rejected by this event's organizer")
//                .font(.system(size: 16, weight: .semibold))
//                .foregroundColor(.red)
//        }
//        .padding()
//        .background(Color.red.opacity(0.1))
//        .frame(maxWidth: .infinity)
//        .cornerRadius(8)
//    }
}


//#Preview {
//    NavigationStack {
//        EventDetail(user: UserMock.instance.user3, event: EventMock.instacne.eventA, path: .constant([]), profilePath: .constant([]), selectedTab: .constant(.home), participantsVM: GetParticipantsByEventIdViewModel(), approvedParticipants: ParticipantMock.instance.participants)
//            .preferredColorScheme(.dark)
//    }
//    .padding(.horizontal,Theme.large)
//
//}

//                                VStack(alignment:.leading) {
//                                    if approvedParticipants.count > 0 {
//                                        NavigationLink {
//                                            AttendeesListView(approvedParticipants: approvedParticipants)
//                                        } label: {
//                                            RoundedRectangle(cornerRadius: Theme.cornerRadius)
//                                                .foregroundStyle(Theme.backgroundColor)
//                                                .frame(maxWidth: .infinity,alignment: .leading)
//                                                .frame(height: 80)
//                                                .applyThemeDoubleShadow()
//                                                .overlay (
//                                                    HStack {
//                                                        attendees
//                                                            .tint(Theme.secondaryTextColor)
//                                                        Spacer()
//                                                    }
//                                                        .padding()
//                                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                                )
//                                        }
//                                    }
//                                }
