//
//  ChildView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import SwiftUI

struct ChildView: View {
    
    let persons = [
        Person(name: "Austin", lastName: "Xu"),
        Person(name: "Jhon", lastName: "Doe")
        
    ]
    
    var body: some View {
        ZStack{
            VStack{
                Text("Child View")
                ForEach(persons, id: \.self){person in
                    NavigationLink(value: HomeNavigation.secondChild(person)) {
                        Text("Click to enter second View")
                    }
                    .navigationTitle("Child")
                }
            }
        }
    }
}

#Preview {
    ChildView()
}
