//
//  PollView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/30.
//

import SwiftUI

enum FocusField: Hashable {
    case pollTitle
    case option(index: Int)
}

struct PollView: View {

    @ObservedObject var poll: PollModel
    @ObservedObject var pollVM: PollViewModel
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Ask a question", text: $poll.pollTitle, onCommit: {
                if !$poll.options.isEmpty {
                    focusedField = .option(index: 0)
                }
            })
            .focused($focusedField, equals: .pollTitle)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .onTapGesture {
                withAnimation {
                    pollVM.toggleEditing(for: pollVM.polls.firstIndex(where: {$0.id == poll.id}) ?? -1)
                }
            }

            if pollVM.editingPollIndex == pollVM.polls.firstIndex(where: {$0.id == poll.id}){
                optionField
                addOptionButton
                editBox
            } else{
                HStack{
                    Spacer()
                    Text("\(poll.options.count) Options")
                        .applyBodyFont()
                        .foregroundStyle(Theme.tintColor)
                }.padding(.horizontal, 8)
            }

            Divider()
        }
        .padding(.horizontal, 8)
        .onReceive(pollVM.$polls) { polls in
            withAnimation {
                pollVM.editingPollIndex = polls.lastIndex(of: poll)
            }
        }
    }
}

extension PollView{
    private var optionField: some View{
        ForEach($poll.options.indices, id: \.self) { index in
            HStack {
                Image("checkbox_active_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    
                TextField("Option \(index + 1)", text: $poll.options[index], onCommit: {
                    if index < poll.options.count - 1 {
                        focusedField = .option(index: index + 1)
                    } else {
                        poll.options.append("")
                        DispatchQueue.main.async {
                            focusedField = .option(index: poll.options.count - 1)
                        }
                    }
                })
                .focused($focusedField, equals: .option(index: index))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.leading, 8)
                
                Button(action: {
                    poll.options.remove(at: index)
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 4)
        }
    }
    
    private var editBox: some View{
        VStack{
            HStack {
                Spacer()
                Text("Allowed multiple answers")
                    .applyOverlayFont()
                Toggle("", isOn: $poll.allowMultipleAnswer)
                    .labelsHidden()
                    .controlSize(.mini)
                    .toggleStyle(CustomToggleStyle())
            }
            .padding(.bottom, 4)
            
            HStack(spacing: Theme.xs){
                Spacer()
                Button {
                    //MARK: - DELETE BUTTON ACTION HERE
                    if pollVM.polls.count == 1{
                        
                    }
                    pollVM.deletePoll(for: pollVM.polls.firstIndex(where: {$0.id == poll.id}) ?? -1)
                } label: {
                    RoundedRectangle(cornerRadius: Theme.cornerRadius)
                        .stroke(Theme.tintColor, lineWidth: 1)
                        .frame(width: 80, height: Theme.buttonHeight)
                        .foregroundStyle(Theme.primaryTextColor)
                        .overlay {
                            Image("trashbin_active_icon")
                        }
                }
                
                Button {
                    //MARK: - SAVE BUTTON ACTION HERE
                    print("Save")
                } label: {
                    Text("Save")
                        .frame(width: 80, height: 40)
                        .foregroundStyle(Theme.primaryTextColor)
                        .applyButtonFont()
                        .background(
                            RoundedRectangle(cornerRadius: Theme.cornerRadius)
                                .frame(height:Theme.buttonHeight)
                                .foregroundStyle(Theme.tintColor)
                        )
                }
            }
        }
        .padding(.horizontal, 8)
        .animation(.easeInOut, value: pollVM.editingPollIndex)
    }
    
    private var addOptionButton: some View{
        HStack{
            Button(action: {
                poll.options.append("")
            }) {
                HStack {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                    Text("Add Option")
                        .applyBodyFont()
                        .padding(.leading, 4)
                }
            }
            .padding(.leading, 16)
            Spacer()
        }
    }
    
}

#Preview {
    PollView(poll: PollModel(), pollVM: PollViewModel())
}
