//
//  CreateEventSuccessView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/29.
//

import SwiftUI

struct CreateEventSuccessView: View {
    
    @Binding var path: NavigationPath
    @Binding var selectedTab: Tab
    @ObservedObject var pollVM: CreatePollViewModel

    var body: some View {
        VStack(alignment:.center,spacing:Theme.defaultSpacing){
            Image(Theme.confirmation)
                .resizable()
                .scaledToFill()
                .frame(width:Theme.vectorImageWidth,height:Theme.vectorImageHeight)
            Image(Theme.congratsText)
                .resizable()
                .scaledToFill()
                .frame(width:173,height:35)
            Text("Your request is on the way.\n We will get back to you.")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .applyLabelFont()
            Button(action: {
                withAnimation {
                    selectedTab = Tab.home
                    path = NavigationPath()
                }
            }) {
                ReusableButton(title: "Back to Home")
            }
            
//            Button(action: {
//                for i in pollVM.polls{
//                    print(i.pollTitle, i.options, i.allowMultipleAnswer)
//                }
//            }, label: {
//                Text("Test Poll")
//                    .frame(maxWidth: .infinity)
//                    .foregroundStyle(Theme.primaryTextColor)
//                    .applyButtonFont()
//                    .padding(.vertical, Theme.medium)
//                    .background(
//                        RoundedRectangle(cornerRadius: Theme.cornerRadius)
//                            .frame(height:Theme.buttonHeight)
//                            .foregroundStyle(Theme.tintColor)
//                    )
//                    .padding(.horizontal, Theme.large)
//            })
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreateEventSuccessView(
        path: .constant(NavigationPath.init()),
        selectedTab: .constant(Tab.createEvent), pollVM: CreatePollViewModel()
    )
}
