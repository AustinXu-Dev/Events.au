//
//  ParticipantManager.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 15/06/2024.
//

import SwiftUI

struct ParticipantManager: View {
    let event : EventModel
    @Binding var showPending : Bool
    let unit : UnitModel
    @ObservedObject var participantVM : GetParticipantsByEventIdViewModel
    @ObservedObject var approvalVM : UpdateParticipantStatusViewModel
    @State private var respondedParticipants: Set<String> = []
//    let pedningParticipants : [ParticipantMode]

    var body: some View {
        VStack(alignment:.center) {
                participantManagerHeader
            if !showPending {
                VStack(alignment:.center,spacing:Theme.medium) {
                    ForEach(participantVM.approvedParticipants,id: \._id){ partipant in
                        ParticipantRow(participant: partipant, unit: unit)
                            .opacity(respondedParticipants.contains(partipant._id ?? "") ? 0 : 1)
//                            .transition(.move(edge: .trailing).combined(with: .opacity))


                    }
                    
                }
                .transition(.move(edge: .leading))
            }
            
            if showPending {
                VStack(alignment:.center,spacing:Theme.medium) {
                    ForEach(participantVM.pendingParticipants,id: \._id){ partipant in
                        ZStack {
                            ParticipantRow(participant: partipant, unit: unit)
                                .opacity(respondedParticipants.contains(partipant._id ?? "") ? 0 : 1)
//                                .transition(.move(edge: .trailing).combined(with: .opacity))

                            if !respondedParticipants.contains(partipant._id ?? "") {
                            HStack {
                                approveButton
                                    .onTapGesture {
                                        withAnimation(.default) {
                                            handleApproval(isApproving: true, participant: partipant)
                                        }
                                      
                                    }
                                rejectButton
                                    .onTapGesture {
                                        withAnimation(.default) {
                                            handleApproval(isApproving: false, participant: partipant)
                                        }
                                       
                                    }
                            }
                            .offset(x:95)
                        }
                        }

                    }
                   
                }
                .transition(.move(edge: .trailing))
            }
            Spacer(minLength: 0)
        }
        .refreshable {
            if let eventId = event._id {
                participantVM.fetchParticipants(id: eventId)
            }
        }
        .onAppear(perform: {
            if let eventId = event._id {
                participantVM.fetchParticipants(id: eventId)
            }
        })
        
      
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
    
    private func handleApproval(isApproving: Bool,participant:ParticipantModel) {
            // Call the approval API or perform action here
        if let eventId = event._id, let token = TokenManager.share.getToken() {
                // Assume `approvalVM` is passed as an environment object
                approvalVM.participantId = participant._id ?? ""
                approvalVM.status = isApproving ? "accepted" : "rejected"
                approvalVM.updateEventBasicInfo(eventId: eventId, token: token)
            }
            
            // Hide the buttons for this row
        withAnimation(.linear) {
            if let participantId = participant._id {
                respondedParticipants.insert(participantId)
            }
        }
    }
    
}





//struct ParticipantManager_Previews : PreviewProvider {
//    static var previews: some View {
//        Group {
//            ParticipantManager(event :EventMock.instacne.eventA ,showPending:.constant(false), unit: UnitMock.instacne.unitA, pendingParticipants: .constant(ParticipantMock.instacne.participants), approvedParticipants: .constant(ParticipantMock.instacne.participants), participantVM: GetParticipantsByEventIdViewModel(), approvalVM: UpdateParticipantStatusViewModel())
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.light)
//                .padding()
//            
//            ParticipantManager(event :EventMock.instacne.eventA ,showPending:.constant(false), unit: UnitMock.instacne.unitA, pendingParticipants: .constant(ParticipantMock.instacne.participants), approvedParticipants: .constant(ParticipantMock.instacne.participants), participantVM: GetParticipantsByEventIdViewModel(),approvalVM: UpdateParticipantStatusViewModel())
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.dark)
//                .padding()
//        }
//
//    }
//}
