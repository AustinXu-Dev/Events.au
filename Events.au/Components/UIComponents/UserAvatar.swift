//
//  UserAvatar.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 21/08/2024.
//


import SwiftUI

struct UserAvatar: View {
    let user: UserModel2
    var body: some View {
            ZStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: Theme.circleWidth, height: Theme.circleHeight)
                    .overlay (
                        Text(user.firstName?.prefix(1) ?? "U")
                            .font(.system(size: 8))
                            .foregroundColor(.white)
                    )
            
            }
        
    }
}

struct UserAvatarSquare : View {
    let user: UserModel2
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray)
                    .frame(width: 64, height: 64)
                    .overlay (
                        Text(user.firstName?.prefix(1) ?? "U")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    )
            }
        
    }
}

struct ParticipantAvatar : View {
    let user: UserModel2
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius))
                    .frame(width:Theme.participantSquareImage,height:Theme.participantSquareImage)

                    .overlay (
                        Text(user.firstName?.prefix(1) ?? "U")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    )
            }
        
    }
}

#Preview {
    UserProfileDetailAvatar(user: UserMock.instance.user3)
}


struct UserToolBarAvatar : View {
    let user: UserModel2
    var body: some View {
            ZStack {
                Circle()
                    .fill(Color.gray)
                    .scaledToFill()
                .frame(width: 35, height: 35)
                    .overlay (
                        Text(user.firstName?.prefix(1) ?? "U")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    )
            }
        
    }
}


struct UserProfileAvatar : View {
    let user: UserModel2
    var body: some View {
        
        ZStack {
            Circle()
                .fill(Color.gray)
                .scaledToFill()
                .frame(width: Theme.imageWidth, height: Theme.imageHeight)
                .overlay (
                    Text(user.firstName?.prefix(1) ?? "U")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                )
        }
        

        
    }
}


struct UserProfileDetailAvatar : View {
    let user: UserModel2
    var body: some View {
        
        ZStack {
            Circle()
                .fill(Color.gray)
                .scaledToFill()
                .frame(width: 100, height: 100)
                .overlay (
                    Text(user.firstName?.prefix(1) ?? "U")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                )
        }
        

        
    }
}

