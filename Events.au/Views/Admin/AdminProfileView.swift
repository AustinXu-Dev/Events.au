//
//  AdminProfileView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 16/6/2567 BE.
//

import SwiftUI

struct AdminProfileView: View {
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
                        ProfileDetailRow(label: "First Name", value: "Justin")
                        ProfileDetailRow(label: "Last Name", value: "Hollan")
                        ProfileDetailRow(label: "Email", value: "u6511923@au.edu")
                        ProfileDetailRow(label: "Phone", value: "0660297968")
                        ProfileDetailRow(label: "Gender", value: "Male")
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
                        EventRow(image: "admin_one", title: "Event Title", date: "5th Jun, 18:00-20:00", status: "Approved")
                        EventRow(image: "admin_two", title: "Event Title", date: "5th Jun, 18:00-20:00", status: "Pending")
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .toolbar {
               ToolbarItem(placement: .navigationBarTrailing) {
                   NavigationLink(destination: EditProfileView()) {
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

struct EditProfileView: View {
    var body: some View {
        Text("Edit Profile")
            .navigationBarTitle("Edit Profile", displayMode: .inline)
    }
}

struct EventRow: View {
    var image: String
    var title: String
    var date: String
    var status: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 64, height: 64)
                .cornerRadius(5)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(date)
                    .font(.system(size: 12))
            }
            
            Spacer()
            
            Text(status)
                .foregroundColor(status == "Approved" ? .black : .gray)
                .padding([.leading, .trailing], 10)
                .padding([.top, .bottom], 2)
                .font(.system(size: 12))
                .background(status == "Approved" ? Color.approved : Color.pending)
                .cornerRadius(5)
                .padding(.bottom, 25)
        }
        .padding(4)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 16)
    }
}

struct AdminProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AdminProfileView()
    }
}
