//
//  CreateEventView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/23.
//

import SwiftUI

struct CreateEventView: View {
    
    var eventNamePlaceholder: String = "Name your event"
    var eventTypePlaceholder: String = "Event Type"
    var locationPlaceholder: String = "Add location"
    var descriptionPlaceholder: String = "Describe your event..."
    @State var datePlaceholder: String = "Add date"
    @State var timePlaceholder: String = "Add time"
    @State var startTimePlaceholder: String = "Start Time"
    @State var endTimePlaceholder: String = "End Time"
    @State var showTimeValidationAlert: Bool = false

    var imagePlaceholder: String = "Add image"

    @State var name: String = ""
    @State var eventType: String = ""
    @State var location: String = ""
    @State var selectedOptionIndex: Int = 0
    @State var showDropDown: Bool = false
    @State var units: [UnitModel] = [
        UnitModel(_id: "1", name: "D*Code", description: ""),
        UnitModel(_id: "2", name: "VMES", description: ""),
        UnitModel(_id: "3", name: "BBA", description: ""),
    ]
    @State var dateValue: Date = Date()
    @State var selectedDate: Date = Date()
    @State var showDateSheet: Bool = false
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()
    @State var showTimeSheet: Bool = false
    @State var description: String = ""
    
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
            ScrollView {
                VStack(alignment: .center,spacing:Theme.defaultSpacing) {
                   
                    nameTextField
                    detailsField(geometry.size.width)
                   
                    descriptionField
                        .padding(.bottom, Theme.headingBodySpacing)

                    Text("Create Event")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Theme.primaryTextColor)
                        .applyButtonFont()
                        .padding(.vertical, Theme.medium)
                        .padding(.horizontal, Theme.large)
                        .background(
                            RoundedRectangle(cornerRadius: Theme.cornerRadius)
                                .frame(height:Theme.buttonHeight)
                                .foregroundStyle(Theme.tintColor)
                        )
                    
                }
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
           .navigationTitle("Event Details")
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
    
    private func detailsField(_ menuWidth: CGFloat) -> some View {
        VStack(alignment: .leading) {
            Text("Details")
                .font(Theme.headingFontStyle)
                .fontWeight(.bold)
            
            //MARK: To get the selected option, use units[selectedOptionIndex]
            DropDownMenu(
                options: units,
                menuWidth: .constant(menuWidth),
                selectedOptionIndex: $selectedOptionIndex,
                showDropdown: $showDropDown
            )
            
            Spacer().frame(height: Theme.large)
            
            TextFieldWithIcon(
                placeHolder: locationPlaceholder, 
                selectedPlaceholder: $location,
                image: "noti_icon")

            Spacer().frame(height: Theme.large)

            TextWithIcon(placeHolder: datePlaceholder, image: "noti_icon")
                .onTapGesture {
                    showDateSheet.toggle()
                }
                
            Spacer().frame(height: Theme.large)

            TextWithIcon(placeHolder: timePlaceholder, image: "noti_icon")
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
                // need to fix
                datePlaceholder = dateToString(date: selectedDate)
                showDateSheet.toggle()
            }, placeholder: "Add date", isSheetPresented: $showDateSheet)
            
            DatePicker("Add Date", selection: $selectedDate, in: dateRange, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding(.horizontal, Theme.large)
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
                    let startTimeValue = timeToString(date: startTime)
                    let endTimeValue = timeToString(date: endTime)
                    timePlaceholder = "\(startTimeValue) - \(endTimeValue)"
                    showTimeSheet.toggle()
                }
            }, placeholder: "Add time", isSheetPresented: $showTimeSheet)
            
//            Section{
//                HStack{
//                    Text(startTimePlaceholder)
//                        .padding(8)
//                        .frame(maxWidth: .infinity, maxHeight: Theme.textFieldHeight, alignment: .leading)
//                    Spacer()
//                    Image("noti_icon") // Replace with your desired icon
//                        .foregroundColor(.gray)
//                        .padding(.trailing, 8)
//                    
//                }
//                .frame(maxWidth: .infinity)
//                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.3), lineWidth: 1))
//                .onTapGesture {
//                    showStartTimeWheel.toggle()
//                }
//                
//                if showStartTimeWheel{
//                    DatePicker("", selection: $startTime, displayedComponents: [.hourAndMinute])
//                        .datePickerStyle(WheelDatePickerStyle())
//                        .zIndex(100)
//                }
//            }
//            .padding()

//            Section{
//                DatePicker("Start Time", selection: $startTime, displayedComponents: [.hourAndMinute])
//                .frame(maxWidth: .infinity, maxHeight: Theme.textFieldHeight)
//                .datePickerStyle(CompactDatePickerStyle())
//                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.3), lineWidth: 1))
//                .padding()
//            }
//            .padding()
//            .onTapGesture {
//                showStartTimeWheel.toggle()
//            }
                
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
                Text("Please adjust your time")
            }
            Spacer()
                
        }
    }
    
    private func dateToString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"

        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    private func timeToString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}


#Preview {
    CreateEventView()
}
