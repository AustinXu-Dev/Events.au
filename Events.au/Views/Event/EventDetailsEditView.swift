//
//  EventDetailsEditView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 17/6/2567 BE.
//

import SwiftUI

struct EventDetailsEditView: View {
    @State private var name: String = "Justin"
    @State private var faculty: String = "VMES"
    @State private var startDate: String = "05/06/2024"
    @State private var endDate: String = "05/06/2024"
    @State private var form: String = "18:00"
    @State private var to: String = "22:00"
    @State private var description: String = "Description of the event"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer().frame(height: 20)
                    
                    HStack {
                        Spacer()
                        Image("event_details")
                            .resizable()
                        Spacer()
                    }
                    .padding([.leading, .trailing], 16)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Name")
                                .font(.body)
                                .bold()
                            Spacer()
                            TextField("", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 200)
                        }
                        HStack {
                            Text("Faculty")
                                .font(.body)
                                .bold()
                            Spacer()
                            TextField("", text: $faculty)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 200)
                        }
                        HStack {
                            Text("Start Date")
                                .font(.body)
                                .bold()
                            Spacer()
                            TextField("", text: $startDate)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 200)
                        }
                        HStack {
                            Text("End Date")
                                .font(.body)
                                .bold()
                            Spacer()
                            TextField("", text: $endDate)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 200)
                        }
                        HStack {
                            Text("From")
                                .font(.body)
                                .bold()
                            Spacer()
                            TextField("", text: $form)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 200)
                        }
                        HStack {
                            Text("To")
                                .font(.body)
                                .bold()
                            Spacer()
                            TextField("", text: $to)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 200)
                        }
                        HStack {
                            Text("Description")
                                .font(.body)
                                .bold()
                            Spacer()
                            TextField("", text: $description)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 200)
                        }
                    }
                    .padding()
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    Button(action: {
                    }) {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.eventBackground)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
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
}

#Preview {
    EventDetailsEditView()
}
