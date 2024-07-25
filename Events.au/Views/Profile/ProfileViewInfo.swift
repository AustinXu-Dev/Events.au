//
//  AdminProfileView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 16/6/2567 BE.
//

import SwiftUI

struct ProfileViewInfo: View {
    let user : UserModel2
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Image("human_profile")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                            ProfileDetailRow(label: "First Name", value: user.firstName)
                            //MARK: add last name after dropping user database
                            ProfileDetailRow(label: "Last Name", value : "Gay")
                            ProfileDetailRow(label: "Email", value: user.email)
                            ProfileDetailRow(label: "Phone", value: "\(user.phone)")
                            ProfileDetailRow(label: "Gender", value: "Gay")
                            ProfileDetailRow(label: "Date of Birth", value: "05/05/2001")
                        
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
                        EventRow(event: EventMock.instacne.eventA)
                        EventRow(event: EventMock.instacne.eventB)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .toolbar {
               ToolbarItem(placement: .navigationBarTrailing) {
                   NavigationLink(destination: ProfileEditView(user: user)) {
                       Image(systemName: "pencil")
                           .imageScale(.large)
                   }
               }
           }
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
                    .frame(width: geometry.size.width * 0.4, alignment: .leading)  // Fixed width for label
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
                    .frame(width: geometry.size.width * 0.6, alignment: .leading)  // Fixed width for value
            }
        }
        .frame(height: 40)
        .padding(.bottom, 8)
    }
}

//struct EditProfileView: View {
//    var body: some View {
//        Text("Edit Profile")
//            .navigationBarTitle("Edit Profile", displayMode: .inline)
//    }
//}

//struct EventRow: View {
//    var image: String
//    var title: String
//    var date: String
//    var status: String
//    
//    var body: some View {
//        HStack {
//            Image(image)
//                .resizable()
//                .frame(width: 64, height: 64)
//                .cornerRadius(5)
//            
//            VStack(alignment: .leading) {
//                Text(title)
//                    .font(.headline)
//                Text(date)
//                    .font(.system(size: 12))
//            }
//            
//            Spacer()
//            
//            Text(status)
//                .foregroundColor(status == "Approved" ? .black : .gray)
//                .padding([.leading, .trailing], 10)
//                .padding([.top, .bottom], 2)
//                .font(.system(size: 12))
//                .background(status == "Approved" ? Color.approved : Color.pending)
//                .cornerRadius(5)
//                .padding(.bottom, 25)
//        }
//        .padding(4)
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
//        .padding(.horizontal, 16)
//    }
//}

struct ProfileViewInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewInfo(user: UserMock.instance.user3)
    }
}
