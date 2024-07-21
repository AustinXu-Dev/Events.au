//
//  CreateEventView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/23.
//

import SwiftUI

struct CreateEventView: View {
    
    @Binding var path: NavigationPath
    @Binding var selectedTab: Tab
    
    var eventNamePlaceholder: String = "Name your event"
    var imagePlaceholder: String = "Add image"
    var eventTypePlaceholder: String = "Event type"
    var locationPlaceholder: String = "Add location"
    var descriptionPlaceholder: String = "Describe your event..."
    var rulesPlaceholder: String = "Describe any rules..."
    //MARK: - This two variables are to display the custom selected text"
    @State var datePlaceholder: String = "Add date"
    @State var timePlaceholder: String = "Add time"
    
    @State var showDateValidationAlert: Bool = false
    @State var showTimeValidationAlert: Bool = false

    //MARK: - DATA FOR API CALL
    @State var name: String = ""
    @State var description: String = ""
    @State var location: String = ""
    @State var startDateValue: String = ""
    @State var endDateValue: String = ""
    @State var startTimeValue: String = ""
    @State var endTimeValue: String = ""
    @State var rules: String = ""
    @State var image: String = ""
    @State var eventType: String = ""
//    @State var units: [UnitModel] = []

    @State var selectedOptionIndex: Int = 0

    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()

    @State var showDropDown: Bool = false
    @State var showDateSheet: Bool = false
    @State var showTimeSheet: Bool = false
    @State var isLoading: Bool = false
    @State var showAlert: Bool = false
    
    @StateObject var allUnitsViewModel = AllUnitsViewModel()
    @StateObject var createEventViewModel: CreateEventViewModel
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        var components = DateComponents()
        components.month = 1
        let endDate = calendar.date(byAdding: components, to: startDate)!
        return startDate...endDate
    }()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ScrollView {
                    VStack(alignment: .center,spacing:Theme.defaultSpacing) {
                        
                        nameTextField
                        imageField
                        detailsField(geometry.size.width)
                        
                        descriptionField
                            .padding(.bottom, Theme.headingBodySpacing)
                        
                        rulesField
                            .padding(.bottom, Theme.headingBodySpacing)
                        
                        nextButton
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, Theme.large)
                    .frame(width: geometry.size.width) // Make VStack span the full width of the screen
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height) // Make ScrollView span the full screen
                .onTapGesture {
                    withAnimation {
                        showDropDown = false
                        showDateSheet = false
                    }
                }
                .navigationBarBackButtonHidden()
                .navigationTitle("Event Details")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            path.removeLast()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Theme.tintColor)
                        })
                    }
                }
                
                if isLoading{
                    LoadingView()
                }
                
            }
       }
        
    }
    
}

extension CreateEventView{
    private var nameTextField: some View{
        VStack(alignment: .leading){
            Text("Name")
                .applyHeadingFont()
//                .font(Theme.headingFontStyle)
            TextField(eventNamePlaceholder, text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: Theme.textFieldHeight)
        }
    }
    
    private var imageField: some View{
        VStack(alignment: .leading){
            Text("Image")
                .font(Theme.headingFontStyle)
                .fontWeight(.semibold)
            TextField(imagePlaceholder, text: $image, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    private var descriptionField: some View{
        VStack(alignment: .leading){
            Text("Description")
                .font(Theme.headingFontStyle)
                .fontWeight(.semibold)
            TextField(descriptionPlaceholder, text: $description, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(3, reservesSpace: true)
            
        }
    }
    
    private var rulesField: some View{
        VStack(alignment: .leading){
            Text("Rules")
                .font(Theme.headingFontStyle)
                .fontWeight(.semibold)
            TextField(rulesPlaceholder, text: $rules, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(3, reservesSpace: true)
            
        }
    }
    
    private func detailsField(_ menuWidth: CGFloat) -> some View {
        VStack(alignment: .leading) {
            Text("Details")
                .font(Theme.headingFontStyle)
                .fontWeight(.bold)
            
            //MARK: To get the selected option, use units[selectedOptionIndex]
            DropDownMenu(
                options: allUnitsViewModel.units,
                menuWidth: .constant(menuWidth),
                selectedOptionIndex: $selectedOptionIndex,
                showDropdown: $showDropDown
            )
            .onAppear{
                allUnitsViewModel.fetchUnits()
            }
//            .onSubmit {
//                createEventViewModel.unitId = allUnitsViewModel.units[selectedOptionIndex].id
//            }
            
            
            Spacer().frame(height: Theme.large)
            
            TextFieldWithIcon(
                placeHolder: locationPlaceholder, 
                selectedPlaceholder: $location,
                image: "location_icon")

            Spacer().frame(height: Theme.large)

            TextWithIcon(placeHolder: datePlaceholder, image: "calendar_icon")
                .onTapGesture {
                    showDateSheet.toggle()
                }
                
            Spacer().frame(height: Theme.large)

            TextWithIcon(placeHolder: timePlaceholder, image: "clock_icon_20")
                .onTapGesture {
                    showTimeSheet.toggle()
                }
            
            
        }
        .sheet(isPresented: $showDateSheet) {
            dateSheet
                .presentationDetents([.height(500), .height(700)])
                .presentationDragIndicator(.automatic)
        }
        .sheet(isPresented: $showTimeSheet, content: {
            timeSheet
                .presentationDetents([.height(500), .height(700)])
                .presentationDragIndicator(.automatic)
        })
    }
    
    private var dateSheet: some View{
        VStack(alignment: .center){
            Spacer().frame(height: 30)
            
            ToolbarView(leftAction: {
                showDateSheet.toggle()
            }, rightAction: {
                if startDate > endDate{
                    showDateValidationAlert.toggle()
                } else{
                    startDateValue = dateToString(date: startDate)
                    endDateValue = dateToString(date: endDate)
//                    createEventViewModel.startDate = dateToString(date: startDate)
//                    createEventViewModel.endDate = dateToString(date: endDate)
                    datePlaceholder = "\(startDateValue) - \(endDateValue)"
                    showDateSheet.toggle()
                }
            }, placeholder: "Add date", isSheetPresented: $showDateSheet)
            
            VStack{
                DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                    .datePickerStyle(CompactDatePickerStyle())
                DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                    .datePickerStyle(CompactDatePickerStyle())
            }
            .padding(.top, Theme.large)
            .padding(.horizontal, Theme.large)
            .alert("Incorrect Date", isPresented: $showDateValidationAlert) {
                Button(action: {
                    
                }, label: {
                    Text("Ok")
                })
                
            } message: {
                Text("Please adjust your date.")
            }
            Spacer()
        }
        
    }
    
    private var timeSheet: some View{
        VStack(alignment: .center){
            Spacer().frame(height: 30)
            ToolbarView(leftAction: {
                showTimeSheet.toggle()
            }, rightAction: {
                if startTime>endTime{
                    showTimeValidationAlert.toggle()
                }
                else {
                    startTimeValue = timeToString(date: startTime)
                    endTimeValue = timeToString(date: endTime)
//                    createEventViewModel.startTime = timeToString(date: startTime)
//                    createEventViewModel.endTime = timeToString(date: endTime)
                    timePlaceholder = "\(startTimeValue) - \(endTimeValue)"
                    showTimeSheet.toggle()
                }
            }, placeholder: "Add time", isSheetPresented: $showTimeSheet)
                
            VStack{
                DatePicker("Start time", selection: $startTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(CompactDatePickerStyle())
                DatePicker("End time", selection: $endTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(CompactDatePickerStyle())
            }
            .padding(.top, Theme.large)
            .padding(.horizontal, Theme.large)
            .alert("Incorrect Time", isPresented: $showTimeValidationAlert) {
                Button(action: {
                    
                }, label: {
                    Text("Ok")
                })
                
            } message: {
                Text("Please adjust your time.")
            }
            Spacer()
        }
    }
    
    private func dateToString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    private func timeToString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    private var nextButton: some View{
        Button(action: {
            //MARK: Create button action here
            withAnimation {
                isLoading = true
            }
            
            //MARK: -Integrating Create Event API Integration
            createEventViewModel.name = name
            createEventViewModel.description = description
            createEventViewModel.startDate = startDateValue
            createEventViewModel.endDate = endDateValue
            createEventViewModel.startTime = startTimeValue
            createEventViewModel.endTime = endTimeValue
            createEventViewModel.location = location
            createEventViewModel.rules = rules
            createEventViewModel.unitId = allUnitsViewModel.units[selectedOptionIndex].id
            createEventViewModel.createEvent(token: TokenManager.share.getToken() ?? "")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // Hide loading spinner and show success screen
                withAnimation {
                    print(name, description, location, startDateValue, endDateValue, startTimeValue, endTimeValue, rules, image, allUnitsViewModel.units[selectedOptionIndex].id)
                    //MARK: -API POST LOGIC HERE
                    //If post is success set the isloading to false to show registration success
                    isLoading = false
                    showAlert = true
                }
            }
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, idealHeight: Theme.buttonHeight)
                .overlay {
                    Text("Next")
                        .applyButtonFont()
                        .foregroundStyle(Theme.primaryTextColor)
                }
                .foregroundStyle(Theme.tintColor)
        })
        .alert("Your event is created successfully.", isPresented: $showAlert) {
//            NavigationLink(value: CreateEventNavigation.createPoll) {
                Text("OK")
//            }
        }
    }
}


#Preview {
    CreateEventView(
        path: .constant(NavigationPath.init()),
        selectedTab: .constant(Tab.createEvent), createEventViewModel: CreateEventViewModel(rules: "")
    )
}
