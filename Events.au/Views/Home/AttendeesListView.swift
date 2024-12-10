//
//  AttendeesListView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 1/7/2567 BE.
//

import SwiftUI
import GoogleSignIn
import Firebase
import FirebaseAuth

struct AttendeesListView: View {
  
  @Binding var path : [HomeNavigation]
  @Binding var profilePath: [ProfileNavigation]
  @Binding var selectedTab: Tab
    let approvedParticipants : [ParticipantModel]
    @StateObject var userUnitsVM = GetUnitsByUserIdViewModel()
    @State private var searchText = ""
  var comingFromProfileTab: Bool

    var filteredAttendees: [ParticipantModel] {
            if searchText.isEmpty {
                return approvedParticipants
            } else {
                return approvedParticipants
            }
    }
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(alignment:.leading) {
                HStack {
                    Image("group_fill")
                        .aspectRatio(contentMode: .fit)
                    Text("\(approvedParticipants.count) Attending")
                        .foregroundColor(.red)
                        .bold()
                    Spacer()
                }
                .padding()
                SearchBarAttendee(text: $searchText)
              ForEach(filteredAttendees,id: \._id) { attendee in
                if !comingFromProfileTab {
                  NavigationLink(value: HomeNavigation.reusableProfile(attendee)) {
                    HStack {
                      UserAvatarSquare(user: attendee.userId ?? UserMock.instance.user3)
                      VStack(alignment: .leading) {
                        Text("\(attendee.userId?.firstName ?? "")")// \(attendee.userId?.lastName ?? "" )")
                          .font(.headline)
                          .foregroundStyle(Theme.secondaryTextColor)
                        HStack {
                          ForEach(userUnitsVM.userUnits,id: \.id) { unit in
                            Text(unit.name ?? "")
                              .font(.subheadline)
                              .foregroundColor(.gray)
                          }
                        }
                        
                        
                      }
                      .padding(.leading, 12)
                    }
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .background(Color.white)
                    .padding(.horizontal,8)
                    .onAppear {
                      userUnitsVM.getUnitsByUserId(id: attendee.userId?._id ?? "")
                    }
                  }
                } else {
                  NavigationLink(value: ProfileNavigation.reusableProfile(attendee)) {
                    HStack {
                      UserAvatarSquare(user: attendee.userId ?? UserMock.instance.user3)
                      VStack(alignment: .leading) {
                        Text("\(attendee.userId?.firstName ?? "")")// \(attendee.userId?.lastName ?? "" )")
                          .font(.headline)
                          .foregroundStyle(Theme.secondaryTextColor)
                        HStack {
                          ForEach(userUnitsVM.userUnits,id: \.id) { unit in
                            Text(unit.name ?? "")
                              .font(.subheadline)
                              .foregroundColor(.gray)
                          }
                        }
                        
                        
                      }
                      .padding(.leading, 12)
                    }
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .background(Color.white)
                    .padding(.horizontal,8)
                    .onAppear {
                      userUnitsVM.getUnitsByUserId(id: attendee.userId?._id ?? "")
                    }
                  }
                }
              }
             
                
                Spacer()
            }
            .navigationBarTitle(Text("Attendees"), displayMode: .inline)
        }
        
      
    }
}

struct SearchBarAttendee: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search"
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}


