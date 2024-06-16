//
//  SecondChildView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/12.
//

import SwiftUI

struct SecondChildView: View {
    
    @State var person: Person

    var body: some View {
        Text("Hello, \(person.name)")
    }
}

#Preview {
    SecondChildView(person: Person(name: "Austin", lastName: "Xu"))
}
