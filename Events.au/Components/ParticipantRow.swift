//
//  ParticipantRow.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 15/06/2024.
//

import SwiftUI

//MARK: - This is a micro component for ParticipantManager 
struct ParticipantRow: View {
 
    //MARK: This can either be pending or approved participant
    let participant : EventParticipantMockModel
    var body: some View {
        ZStack {
        RoundedRectangle(cornerRadius: Theme.cornerRadius)
            .frame(width: Theme.participantRectWidth,height: Theme.participantRectHeight)
            .foregroundStyle(Theme.backgroundColor)
            .applyThemeDoubleShadow()
        
        
            HStack(alignment:.center,spacing:Theme.medium) {
                Image(participant.image)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius))
                .frame(width:Theme.participantSquareImage,height:Theme.participantSquareImage)
            
            
                VStack(alignment:.leading,spacing:Theme.medium) {
                Text(participant.name)
                    .applyHeadingFont()
                Text(participant.unit)
                    .applyOverlayFont()
                
                
            }
            Spacer()
        }
        .padding(Theme.xs)
            

        
        }
        
    }
}

struct ParticipantRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ParticipantRow(participant: EventParticipantsMock.instance.profile)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            ParticipantRow(participant: EventParticipantsMock.instance.profile)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
