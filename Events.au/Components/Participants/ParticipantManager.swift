//
//  ParticipantManager.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 15/06/2024.
//

import SwiftUI

struct ParticipantManager: View {
    @Binding var showPending : Bool
    let unit : UnitModel
    @Binding var pendingParticipants : [ParticipantModel]
    @Binding var approvedParticipants : [ParticipantModel]
    
    var body: some View {
        VStack(alignment:.center) {
                participantManagerHeader
            
            
            if !showPending {
                VStack(alignment:.center,spacing:Theme.medium) {
                    ForEach(approvedParticipants,id: \._id){ partipant in
                        ParticipantRow(participant: partipant, unit: unit)
                           
                    }
                }.transition(.move(edge: .leading))
            }
            
            if showPending {
                VStack(alignment:.center,spacing:Theme.medium) {
                    ForEach(pendingParticipants,id: \._id){ partipant in
                        ZStack {
                            ParticipantRow(participant: partipant, unit: unit)
                                
                            HStack {
                                approveButton
                                    .onTapGesture {
                                        withAnimation(.default) {
                                            approvalHandler(isApproving: true, participant: partipant)
                                        }
                                        print("Pending:\(pendingParticipants.count)")
                                        print("Approved:\(approvedParticipants.count)")

                                    }
                                rejectButton
                                    .onTapGesture {
                                        withAnimation(.default) {
                                            approvalHandler(isApproving: false, participant: partipant)
                                        }
                                        print("Pending:\(pendingParticipants.count)")
                                        print("Approved:\(approvedParticipants.count)")

                                    }
                            }
                            .offset(x:95)
                        }
                        
                        
                    }
                   
                }
                .transition(.move(edge: .trailing))
            }
            Spacer(minLength: 0)
        }
        
      
    }
}



extension ParticipantManager {
    private var participantManagerHeader : some View {
        HStack {
            VStack(alignment:.center) {
                Text("Current")
                    .applyLabelFont()
                    .onTapGesture {
                        withAnimation {
                            self.showPending = false
                        }
                    }
                Rectangle()
                    .foregroundStyle(Theme.tintColor)
                    .frame(width:150,height:3)
                    .opacity(showPending ? 0 : 1)
            }
            
            Spacer(minLength: 0)
            VStack(alignment:.center) {
                Text("Pending")                            
                    .applyLabelFont()
                    .onTapGesture {
                        withAnimation {
                            self.showPending = true
                        }
                    }
                Rectangle()
                    .foregroundStyle(Theme.tintColor)
                    .frame(width:150,height:3)
                    .opacity(showPending ? 1 : 0)
                
            }
            
        }
    }
    
    
    
    
    
    private var approveButton : some View {
        
        Text("Approve")
            .foregroundStyle(Theme.secondaryTextColor)
            .applyHeadingFont()
            .applyThemeDoubleShadow()
            .padding(.horizontal,Theme.large)
            .padding(.vertical,Theme.small)
            .background(
                Theme.greenFaint
            )
            .frame(height:Theme.buttonHeight)
            .cornerRadius(Theme.cornerRadius)
    }
    
    private var rejectButton : some View {
      
           Image(systemName: "xmark")
                .frame(width: Theme.iconWidth,height:Theme.iconHeight)
                .foregroundStyle(Theme.tintColor)
        
        .applyThemeDoubleShadow()
        .padding(.horizontal,Theme.large)
        .padding(.vertical,Theme.small)
        .background(
            Theme.redFaint
        )
        .frame(width:Theme.buttonHeight,height:Theme.buttonHeight)
        .cornerRadius(Theme.cornerRadius)
    }
    
    
}



extension ParticipantManager {
    
    private func approvalHandler(isApproving : Bool,participant : ParticipantModel){
        if isApproving {
            approvedParticipants.append(participant)
        }
        pendingParticipants.removeAll{ $0 == participant }
    }
    
}





//struct ParticipantManager_Previews : PreviewProvider {
//    static var previews: some View {
//        Group {
//            ParticipantManager()
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.light)
//                .padding()
//            
//            ParticipantManager()
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.dark)
//                .padding()
//        }
//
//    }
//}
