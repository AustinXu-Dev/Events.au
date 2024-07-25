//
//  EventRegistrationView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/24.
//

import SwiftUI

struct EventRegistrationView: View {
    
    let event : EventModel
    @Binding var path: [HomeNavigation]
    @Binding var selectedTab: Tab

    var nickNamePlaceholder: String = "Nick Name"
    var lineIdPlaceholder: String = "Line ID"
    var contactNumberPlaceholder: String = "+66"
    var remarkPlaceholder: String = "For example: I'm allergic to peanuts"
    
    @State var nickName: String = ""
    @State var lineId: String = ""
    @State var contactNumber: String = ""
    @State var isPhoneNumberValid: Bool = false
    @State var remark: String = ""
    @State var showSuccess: Bool = false
    @State var isLoading: Bool = false
    @State var showAlert: Bool = false
    
    @StateObject var userJoineEventViewModel = UserJoinEventViewModel()
    @StateObject var getPollsByEventIdVM = GetPollsByEventIdViewModel()
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                ScrollView {
                    VStack(alignment: .center, spacing:Theme.defaultSpacing) {
                        imageField
                        
                        detailsField
                        
                        pollField
                        registerButton
                        
                    }
                    .padding(.horizontal, Theme.large)
                    .frame(width: geometry.size.width)
                    
                    
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .navigationTitle("Register Now")
                if isLoading { LoadingView() }
                
                    
            }
            .onAppear(perform: {
                getPollsByEventIdVM.getPollsByEventId(id: event._id ?? "")
                print(event.name ?? "")
            })
        }
    }
}

extension EventRegistrationView{
    private var imageField: some View{
        Image("EventImagePreview")
            .resizable()
            .scaledToFill()
            .frame(width: Theme.eventImageWidth, height: Theme.eventImageHeight)
    }
    
    private var detailsField: some View{
        VStack(alignment: .leading, spacing: Theme.headingBodySpacing){
            Text("Nick Name")
                .applyHeadingFont()
            TextField(nickNamePlaceholder, text: $nickName)
                .frame(height: Theme.textFieldHeight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text("Line ID")
                .applyHeadingFont()
            TextField(lineIdPlaceholder, text: $lineId)
                .frame(height: Theme.textFieldHeight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text("Contact Number")
                .applyHeadingFont()
            TextField("Enter phone number", text: $contactNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
                .onChange(of: contactNumber, initial: true) { oldValue, newValue in
                    if !newValue.isEmpty {
                        isPhoneNumberValid = validatePhoneNumber(newValue)
                    } else {
                        isPhoneNumberValid = true
                    }
                }
            
            if !isPhoneNumberValid {
                Text("Invalid phone number")
                    .foregroundColor(.red)
            }
            
            Text("Remark")
                .applyHeadingFont()
            TextField(remarkPlaceholder, text: $remark, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(3, reservesSpace: true)

        }
    }
    
    private var registerButton: some View{
        
        Button(action: {
            //MARK: Register button action here
            withAnimation {
                isLoading = true
                if let eventId = event._id, let token = TokenManager.share.getToken() {
                    userJoineEventViewModel.userJoinEvent(eventId: eventId, token: token)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // Hide loading spinner and show success screen
                withAnimation {
                    //MARK: -API POST LOGIC HERE
                    print(nickName, lineId, contactNumber, remark)
                    //If post is success set the isloading to false to show registration success
                    isLoading = false
                    showAlert = true
                }
            }
        }, label: {
            RoundedRectangle(cornerRadius: 5)
                .frame(maxWidth: .infinity, idealHeight: Theme.buttonHeight)
                .overlay {
                    Text("Register")
                        .applyButtonFont()
                        .foregroundStyle(Theme.primaryTextColor)
                }
                .foregroundStyle(Theme.tintColor)
        })
        .alert("Your registration is successful.", isPresented: $showAlert) {
            NavigationLink(value: HomeNavigation.registrationSuccess) {
                Text("OK")
            }
        }
    }
    
    private var pollField: some View{
        VStack(alignment: .leading, spacing: Theme.headingBodySpacing){
            ForEach(getPollsByEventIdVM.polls, id: \._id){ poll in
                RegistrationPollView(poll: poll)
            }
        }
    }
    
    private var submitpollResultButton: some View{
        Button {
            //
        } label: {
            Text("Submit poll result")
        }

    }
    
    private func validatePhoneNumber(_ number: String) -> Bool {
        let phoneNumberPattern = "^\\+?[1-9]\\d{1,14}$"
        let result = number.range(of: phoneNumberPattern, options: .regularExpression)
        return (result != nil)
    }
}

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.75)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                Text("Loading...")
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: 200, height: 200)
            }
            .offset(y: -70)
        }
    }
}

struct RegistrationPollView: View{
    var poll: PollModel
    @State private var selectedOptions: [String] = []
//    @State private var textFieldInputs: [String: String] = [:]
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.headingBodySpacing) {
            Text(poll.title)
                .applyHeadingFont()
            
            ForEach(poll.options, id: \._id) { option in
                Button(action: {
                    if poll.multi_select {
                        if selectedOptions.contains(option._id) {
                            selectedOptions.removeAll { $0 == option._id }
                        } else {
                            selectedOptions.append(option._id)
                        }
                    } else {
                        selectedOptions = [option._id]
                    }
                }) {
                    HStack {
                        if selectedOptions.contains(option._id) {
                            Image("checkbox_active_icon")
                        } else{
                            Image("checkbox_icon")
                        }
                        Text(option.title)
                            .applyBodyFont()
                            .foregroundStyle(Theme.secondaryTextColor)
                        Spacer()
                    }
                }
            }
            
            if poll.multi_select{
                Text("*Select multiple options if needed")
                    .font(.footnote)
                    .fontWeight(.light)
            }
        }
    }
}

#Preview {
    EventRegistrationView(event: EventMock.instacne.eventA, path: .constant([]), selectedTab: .constant(.home))
}
