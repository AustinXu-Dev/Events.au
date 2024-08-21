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
//                Image("PersonD")
//                .resizable()
//                .scaledToFill()
//                .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius))
//                .frame(width:Theme.participantSquareImage,height:Theme.participantSquareImage)
                if let imageUrl = FirebaseManager.shared.auth.currentUser?.photoURL {
                    RemoteParticipantImage(url: "\(imageUrl)")
                }
            
            
                VStack(alignment:.leading,spacing:Theme.medium) {
                    //MARK: - participant email is not included in schema right now
                    
                    Text(participant.userId?.firstName ?? "Unknown Name")
                        .lineLimit(1)
                    .applyHeadingFont()
                    Text(unit.name ?? "Unknown Faculty")
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
            ParticipantRow(participant: ParticipantMock.instance.participantA, unit: UnitMock.instacne.unitA)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            ParticipantRow(participant: ParticipantMock.instance.participantB,unit: UnitMock.instacne.unitB)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
