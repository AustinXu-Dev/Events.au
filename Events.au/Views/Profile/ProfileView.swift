//
//  ProfileView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 18/6/2567 BE.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var index = 1
    @State private var selectedGender: String = "Select Gender"
    @State private var selectedFacultyName: String = ""
    @State private var selectedFacultyId : Int?
    @State private var selectedUnitName: String = ""
    @State private var showUpcoming : Bool = false
    @State private var ongoingEvents : [EventModel] = EventMock.instacne.allEvents
    @State private var upcomingEvents : [EventModel] = EventMock.instacne.allEvents
    @State private var faculties: [Faculty] = [
        Faculty(id: 1, name: "VMS"),
        Faculty(id: 2, name: "BBA"),
        Faculty(id: 3, name: "LAW"),
    ]
    @StateObject private var profileVM : GetOneUserByIdViewModel = GetOneUserByIdViewModel()
    
    
    var body: some View {
        VStack(spacing:Theme.defaultSpacing) {
            VStack(alignment:.leading) {
                headerProfile
                if let userName = profileVM.userDetail?.firstName {
                    Text(userName)
                        .applyProfileNameFont()
                }
                HStack {
                    accountSelectionRow
                    Spacer()
                    profileDetailButton
                }
            }
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 0))
            EventManager(showUpcoming: $showUpcoming, ongoingEvents: $ongoingEvents, upcomingEvents: $upcomingEvents)
        }
        .padding(.horizontal,Theme.large)
        .onAppear(perform: {
            if let userId = KeychainManager.shared.keychain.get("appUserId") {
                profileVM.getOneUserById(id: userId)
            }
        })
      
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    
    private var headerProfile : some View {
       VStack {
            Image("wallpaper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:393,height: 186)
                .overlay(
            Image("human_profile")
                .resizable()
                .clipShape(Circle())
                .frame(width: Theme.imageWidth, height: Theme.imageHeight)
            )
             
        }
        
  
    }
    
    
    
    private var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Image("wallpaper")
                .resizable()
                .aspectRatio(contentMode: .fill)
//                .ignoresSafeArea()
            
            VStack(alignment:.leading) {
                Image("human_profile")
                    .resizable()
                    .frame(width: Theme.imageWidth, height: Theme.imageHeight,alignment: .leading)
                    .clipShape(Circle())
                    .offset(x:-16,y:-24)
                }
        }
//        .frame(height: 96)
    }
    
    private var accountSelectionRow : some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
                    .frame(width:174.5,height: 40)
                .overlay(
                    //MARK: -have to fix this (shouldn't be a text field)
                    Group {
                        HStack {
                            TextField("Audience", text: $selectedUnitName)
                                .foregroundColor(Color.eventBackground)
                            Menu {
                                ForEach(faculties, id: \.id) { faculty in
                                    Button(faculty.name) {
                                        selectedFacultyId = faculty.id
                                        selectedFacultyName = faculty.name
                                    }
                                }
                            } label: {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.black)
                            }
                        }
                        
                    }
                        .padding(.vertical,Theme.medium)
                        .padding(.horizontal,Theme.large)
                        .tint(Color.eventBackground)
                )
               
             
        }
    }
    
    private var profileDetailButton : some View {
        Button(action: {
            print("Button clicked")
        }) {
            HStack {
                Image(systemName: "pencil")
                Text("Profile Detail")
                    .applyButtonFont()
            }
            .foregroundColor(.white)
        }
        .padding(.vertical,Theme.medium)
        .padding(.horizontal,Theme.large)
        .frame(width: 174.5)
        .background(Theme.tintColor)
        .cornerRadius(Theme.cornerRadius)
    }
    
}



//struct EventStatusModel: Identifiable {
//    let id = UUID()
//    var image: String
//    var title: String
//    var date: String
//    var status: String
//}
//
//
//let onGoing = [
//    EventStatusModel(image: "admin_one", title: "Event Title", date: "5th Jun, 18:00-20:00", status: "Approved"),
//    EventStatusModel(image: "admin_two", title: "Event Title", date: "5th Jun, 18:00-20:00", status: "Pending")
//]
//
//let upComing = [
//    EventStatusModel(image: "admin_one", title: "Event Title", date: "5th Jun, 18:00-20:00", status: "Approved"),
//    EventStatusModel(image: "admin_two", title: "Event Title", date: "5th Jun, 18:00-20:00", status: "Pending")
//]
//
//
//struct DrapDownButton: View {
//    @State private var isDropdownOpen = false
//    @State private var selectedOption = "Audience"
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                withAnimation {
//                    self.isDropdownOpen.toggle()
//                }
//            }) {
//                HStack {
//                    Text(selectedOption)
//                        .foregroundColor(Color.eventBackground)
//                    Image(systemName: "chevron.down")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(.black)
//                        .frame(width: 10, height: 10)
//                }
//                .padding(6)
//                .padding([.leading, .trailing], 20)
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
//            }
//            .buttonStyle(PlainButtonStyle())
//            
//            if isDropdownOpen {
//                VStack {
//                    Button(action: {
//                        self.selectedOption = "Option 1"
//                        withAnimation {
//                            self.isDropdownOpen = false
//                        }
//                    }) {
//                        Text("Option 1")
//                            .foregroundColor(.black)
//                            .padding()
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    Button(action: {
//                        self.selectedOption = "Option 2"
//                        withAnimation {
//                            self.isDropdownOpen = false
//                        }
//                    }) {
//                        Text("Option 2")
//                            .foregroundColor(.black)
//                            .padding()
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    Button(action: {
//                        self.selectedOption = "Option 3"
//                        withAnimation {
//                            self.isDropdownOpen = false
//                        }
//                    }) {
//                        Text("Option 3")
//                            .foregroundColor(.black)
//                            .padding()
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                }
//                .background(Color.white)
//                .cornerRadius(8)
//                .shadow(radius: 5)
//            }
//        }
//        .padding(.leading, 16)
//        .frame(height: 40)
//    }
//}




//                HStack(spacing: 0) {
//                    Spacer()
//
//                    GeometryReader { geometry in
//                        VStack {
//                            Text("Ongoing")
//                                .fontWeight(.bold)
//                                .padding(.vertical, 10)
//                                .padding(.horizontal, 35)
//                                .background(
//                                    VStack(spacing: 0) {
//                                        Spacer()
//                                        if self.index == 1 {
//                                            Rectangle()
//                                                .fill(Color.eventBackground)
//                                                .frame(width: geometry.size.width, height: 2)
//                                        }
//                                    }
//                                        .padding(.leading, 10)
//                                )
//                                .onTapGesture {
//                                    withAnimation(.default) {
//                                        self.index = 1
//                                    }
//                                }
//                        }
//                    }
//                    .padding(.leading, 16)
//                    .frame(height: 40)
//
//                    Spacer()
//
//                    GeometryReader { geometry in
//                        VStack {
//                            Text("Upcoming")
//                                .fontWeight(.bold)
//                                .padding(.vertical, 10)
//                                .padding(.horizontal, 35)
//                                .background(
//                                    VStack(spacing: 0) {
//                                        Spacer()
//                                        if self.index == 2 {
//                                            Rectangle()
//                                                .fill(Color.eventBackground)
//                                                .frame(width: geometry.size.width, height: 2)
//                                                .padding(.leading, 10)
//                                        }
//                                    }
//                                )
//                                .onTapGesture {
//                                    withAnimation(.default) {
//                                        self.index = 2
//                                    }
//                                }
//                        }
//                    }
//                    .frame(height: 40)
//
//                    Spacer()
//                }
//                .padding(.top, 16)
//                .padding(.bottom, 12)

//                if index == 1 {
//                    ProfileGribView(allEvents: onGoing)
//                } else if index == 2 {
//                    ProfileGribView(allEvents: upComing)
//                }
//                Spacer()
//            }
//            .padding(.top, 70)





//struct ProfileGribView : View {
//    var allEvents: [EventStatusModel]
//    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
//
//    var body: some View {
//        ForEach(allEvents) { event in
//            VStack {
//                HStack {
//                    Image(event.image)
//                        .resizable()
//                        .frame(width: 64, height: 64)
//                        .cornerRadius(5)
//
//                    VStack(alignment: .leading) {
//                        Text(event.title)
//                            .font(.headline)
//                        Text(event.date)
//                            .font(.system(size: 12))
//                    }
//
//                    Spacer()
//
//                    Text(event.status)
//                        .foregroundColor(event.status == "Approved" ? .black : .gray)
//                        .padding([.leading, .trailing], 10)
//                        .padding([.top, .bottom], 2)
//                        .font(.system(size: 12))
//                        .background(event.status == "Approved" ? Color.approved : Color.pending)
//                        .cornerRadius(5)
//                        .padding(.bottom, 25)
//                }
//                .padding(4)
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
//                .padding(.horizontal, 16)
//            }
//        }
//    }
//}
