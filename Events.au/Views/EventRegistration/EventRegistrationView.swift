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
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                ScrollView {
                    VStack(alignment: .center, spacing:Theme.defaultSpacing) {
                        imageField
                        
                        detailsField
                        registerButton
                        
                    }
                    .padding(.horizontal, Theme.large)
                    .frame(width: geometry.size.width)
                    
                    
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .navigationTitle("Register Now")
                if isLoading { LoadingView() }
                
                    
            }
            .onAppear(perform: {
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
            Text("Name")
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

#Preview {
    EventRegistrationView(event: EventMock.instacne.eventA, path: .constant([]), selectedTab: .constant(.home))
}
