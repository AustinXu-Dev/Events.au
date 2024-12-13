//
//  AdminProfileView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 16/6/2567 BE.
//

import SwiftUI

struct ProfileViewInfo: View {
    
    @Binding var path: [ProfileNavigation]
    @Binding var selectedTab: Tab
    @AppStorage("userRole") private var userRole: String?
    let user : UserModel2
    @ObservedObject var participantEventsVM : ParticipantEventsViewModel
    @ObservedObject var organizerEventsVM : OrganizerEventsViewModel
    @StateObject var eventParticipants = GetParticipantsByEventIdViewModel()
    @StateObject var participantVM : GetParticipantsByUserIdViewModel = GetParticipantsByUserIdViewModel()
    @StateObject var unitVM = GetUnitsByEventViewModel()
    @ObservedObject  var profileVM : GetOneUserByIdViewModel
    @StateObject var updateUserViewModel = UpdateUserViewModel()
    
    @State private var isEditMode = false
    @State private var firstName: String = ""
    @State private var phone: String = ""
    @State private var gender: String = ""
    @State private var dob: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    if let user = profileVM.userDetail {
                        UserProfileDetailAvatar(user: user)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                VStack(alignment: .leading, spacing: 10) {
                    if isEditMode {
                        ProfileEdit(label: "First Name", value: $firstName, placeholder: profileVM.userDetail?.firstName ?? "")
                        ProfileEdit(label: "Phone", value: $phone, placeholder: "\(profileVM.userDetail?.phone ?? 00)")
                        ProfileDetailRow(label: "Email", value: profileVM.userDetail?.email ?? "")
                    } else {
                        ProfileDetailRow(label: "First Name", value: profileVM.userDetail?.firstName ?? "")
                        ProfileDetailRow(label: "Phone", value: "\(profileVM.userDetail?.phone ?? 00)")
                        ProfileDetailRow(label: "Email", value: profileVM.userDetail?.email ?? "")
                        //                        ProfileDetailRow(label: "Gender", value: "Gender")
                        //                        ProfileDetailRow(label: "Date of Birth", value: "05/05/2001")
                    }
                }
                .padding()
                .padding(.horizontal, 16)
                
                Divider()
                
                
                Text("Event History")
                    .font(.system(size: 20))
                    .padding(.top, 20)
                    .padding(.horizontal, 34)
                    .bold()
                VStack(spacing: 10) {
                    if userRole == UserState.audience.rawValue {
                        ForEach(participantEventsVM.participantEvents,id: \._id){ participant in
                            if let event = participant.eventId {
                                if event.status == "completed" {
                                    ForEach(participantVM.participant) { fetchedParticipant in
                                        EventRow(event: event, eventParticipants: eventParticipants, unitVM: unitVM, participant: fetchedParticipant)
                                    }
                                }
                            }
                        }
                    } else {
                        ForEach(organizerEventsVM.organizerEvents,id: \._id){ organizer in
                            if let event = organizer.eventId {
                                if event.status == "completed" {
                                    ForEach(participantVM.participant) { fetchedParticipant in
                                        EventRow(event: event, eventParticipants: eventParticipants, unitVM: unitVM, participant: fetchedParticipant)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .refreshable {
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                profileVM.getOneUserById(id: userId)
            }
        }
        .onAppear(perform: {
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                if userRole == UserState.audience.rawValue {
                    self.participantEventsVM.fetchEvents(userId: userId)
                } else {
                    self.organizerEventsVM.fetchEventsByOrganizer(id: userId)
                }
                if let user = profileVM.userDetail {
                    firstName = user.firstName ?? ""
                    phone = "\(user.phone ?? 00)"
                }
            }
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if isEditMode {
                        updateUserDetails()
                    }
                    isEditMode.toggle()
                }label: {
                    Image(systemName: isEditMode ? "checkmark" : "pencil")
                        .imageScale(.large)
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
    
    private func updateUserDetails() {
        updateUserViewModel.firstName = firstName
        updateUserViewModel.phone = phone
        if let userId = KeychainManager.shared.keychain.get("appUserId") {
            updateUserViewModel.updateUser(id: userId, token: TokenManager.share.getToken() ?? "")
        }
    }
}

struct ProfileDetailRow: View {
    var label: String
    var value: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(label)
                    .font(.body)
                    .bold()
                    .frame(width: geometry.size.width * 0.4, alignment: .leading)
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
                    .frame(width: geometry.size.width * 0.6, alignment: .leading)
            }
        }
        .frame(height: 40)
        .padding(.bottom, 8)
    }
}

struct ProfileEdit: View {
    var label: String
    @Binding var value: String
    var placeholder: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(label)
                    .font(.body)
                    .bold()
                    .frame(width: geometry.size.width * 0.4, alignment: .leading)
                
                ZStack(alignment: .leading) {
                    if value.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                    }
                    TextField("", text: $value)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .frame(width: geometry.size.width * 0.6)
            }
        }
        .frame(height: 40)
        .padding(.bottom, 8)
    }
}

struct ProfileViewInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewInfo(path: .constant([]), selectedTab: .constant(.profile),user: UserMock.instance.user3,participantEventsVM: ParticipantEventsViewModel(),organizerEventsVM: OrganizerEventsViewModel(), profileVM: GetOneUserByIdViewModel())
    }
}
