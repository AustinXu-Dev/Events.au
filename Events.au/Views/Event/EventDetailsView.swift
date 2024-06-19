//
//  EventDetailsView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 17/6/2567 BE.
//

import SwiftUI

struct EventDetailsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Image("event_details")
                            .resizable()
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding([.leading, .trailing], 16)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ProfileDetailRow(label: "Name", value: "Code Club Connect")
                        ProfileDetailRow(label: "Faculty", value: "VMES")
                        ProfileDetailRow(label: "Start Date", value: "05/06/2024")
                        ProfileDetailRow(label: "End Date", value: "05/06/2024")
                        ProfileDetailRow(label: "From", value: "18:00")
                        ProfileDetailRow(label: "To", value: "22:00")
                        ProfileDetailRow(label: "Description", value: "Description of the event")
                    }
                    .padding()
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
            .navigationBarTitle("Event Details", displayMode: .inline)
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

#Preview {
    EventDetailsView()
}
