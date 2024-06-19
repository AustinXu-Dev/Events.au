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
    let participant : ParticipantModel
    let unit : UnitModel
    var body: some View {
        ZStack {
        RoundedRectangle(cornerRadius: Theme.cornerRadius)
            .frame(width: Theme.participantRectWidth,height: Theme.participantRectHeight)
            .foregroundStyle(Theme.backgroundColor)
            .applyThemeDoubleShadow()
        
        
            HStack(alignment:.center,spacing:Theme.medium) {
                Image("PersonD")
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius))
                .frame(width:Theme.participantSquareImage,height:Theme.participantSquareImage)
            
            
                VStack(alignment:.leading,spacing:Theme.medium) {
                    //MARK: - this should be participant name
                Text(participant.email)
                    .applyHeadingFont()
                    Text(unit.name)
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
            ParticipantRow(participant: ParticipantMock.instacne.participantA, unit: UnitMock.instacne.unitA)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            ParticipantRow(participant: ParticipantMock.instacne.participantB,unit: UnitMock.instacne.unitB)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
