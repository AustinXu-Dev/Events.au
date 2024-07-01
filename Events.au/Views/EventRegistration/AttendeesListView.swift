//
//  AttendeesListView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 1/7/2567 BE.
//

import SwiftUI

struct Attendee: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let role: String
}

struct AttendeesListView: View {
    
    @State private var searchText = ""

    let attendees: [Attendee] = [
        Attendee(name: "Participant One", imageName: "PersonD", role: "VMES"),
        Attendee(name: "Participant Two", imageName: "PersonE", role: "VMES")
    ]
    
    var filteredAttendees: [Attendee] {
            if searchText.isEmpty {
                return attendees
            } else {
                return attendees.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("group_fill")
                        .aspectRatio(contentMode: .fit)
                    Text("\(attendees.count) Attending")
                        .foregroundColor(.red)
                        .bold()
                    Spacer()
                }
                .padding()

                SearchBarAttendee(text: $searchText)

                List(filteredAttendees) { attendee in
                    HStack {
                        Image(attendee.imageName)
                            .resizable()
                            .frame(width: 64, height: 64)
                            .cornerRadius(5)
                        VStack(alignment: .leading) {
                            Text(attendee.name)
                                .font(.headline)
                            Text(attendee.role)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 12)
                    }
                }
                .listStyle(PlainListStyle())
                
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
