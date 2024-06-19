//
//  GribView.swift
//  Events.au
//
//  Created by Kelvin Gao  on 17/6/2567 BE.
//

import SwiftUI

struct GridView: View {
    var participants: [Participant]
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        ForEach(participants) { participant in
            VStack {
                HStack {
                    Image(participant.imageName)
                        .resizable()
                        .frame(width: 64, height: 64)
                        .cornerRadius(5)
                    
                    VStack(alignment: .leading) {
                        Text(participant.name)
                            .font(.system(size: 20))
                            .bold()
                        Text(participant.role)
                            .font(.system(size: 12))
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(4)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
            }
        }
    }
}
