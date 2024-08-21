//
//  ProfileImage.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 13/06/2024.
//

import SwiftUI

//MARK: - This is a micro component for EventCard
struct EventParticipants: View {
    
    //MARK: - this can either be pending or approved participants
    let participants : [ParticipantModel]
    let participantStatus : String
    
    var body: some View {
            HStack(spacing:0) {
                HStack(spacing:-8) {
                    
                    //I will only display the number circle if participant count >= 5
                    ForEach(participants.count == 5 ? Array(participants.prefix(upTo: 4)) : participants,id: \._id) { participant in
                        ZStack {
                            //MARK: have to change to image downloading logic from server
                            //MARK: only get the approved participant here
                            if let imageUrl = FirebaseManager.shared.auth.currentUser?.photoURL {
                                RemoteSmallParticipantImage(url: "\(imageUrl)")
                            }
                            // Image("PersonB")
//                                .resizable()
//                                .clipShape(Circle())
//                                .frame(width: Theme.circleWidth,height:Theme.circleHeight)
//                                .aspectRatio(contentMode:.fit)
                            Circle()
                                .stroke(.white,lineWidth: 1)
                                .frame(width: Theme.circleWidth,height:Theme.circleHeight)
                        }
                        
                    } //end of ForEach loop
                    if participants.count >= 5 {
                        // only show this if the count is >= 5
                        ZStack {
                            Circle()
                                .frame(width: Theme.circleWidth,height: Theme.circleHeight)
                                .foregroundStyle(Theme.redFaint)
                                .overlay(
                                    Text("+\(participants.count-4)")
                                        .applyOverlayFont()
                                        .foregroundStyle(.black)
                                    
                                )
                            Circle()
                                .stroke(.white,lineWidth: 1)
                                .frame(width: Theme.circleWidth,height:Theme.circleHeight)
                        }
                    } // end of condition
                }
                .applyThemeDoubleShadow()
                if participants.count > 0 {
                    Text(participantStatus)
                        .applyOverlayFont()
                        .padding(.horizontal,Theme.small)
                }
            }
        
    }
}

struct EventParticipants_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            EventParticipants(participants: ParticipantMock.instance.participants, participantStatus: "joining")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .padding()
            
            EventParticipants(participants: ParticipantMock.instance.participants,participantStatus: "joining")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}


//if let profileURL = photoURL {
//    AsyncImage(url: photoURL) { result in
//        switch result {
//        case .empty:
//            ProgressView()
//        case .success(let image):
//            image.resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 20, height: 20)
//                .clipShape(Circle())
//        case .failure:
//            Image(systemName: "person.crop.circle.fill.badge.exclamationmark")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 20, height: 20)
//                .clipShape(Circle())
//        @unknown default:
//            EmptyView()
//        }
//    }
//}




//HStack(spacing:0) {
//
//    HStack(spacing:-5) {
//        ForEach(mockData.prefix(upTo: 4),id: \.id){ image in
//            ZStack {
//                Image(image.name)
//                    .resizable()
//                    .clipShape(Circle())
//                    .frame(width: Theme.circleWidth,height:Theme.circleHeight)
//                    .scaledToFill()
//
//
//                Circle()
//                    .stroke(.white,lineWidth: 1)
//                    .frame(width: Theme.circleWidth,height:Theme.circleHeight)
//            }
//
//
//
//        }
//
//    }
//}
