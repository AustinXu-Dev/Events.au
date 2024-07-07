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
        UnitModel(id: "1", name: "D*Code", description: ""),
        UnitModel(id: "2", name: "VMES", description: ""),
        UnitModel(id: "3", name: "BBA", description: ""),
    ]
    @State var dateValue: Date = Date()
    @State var selectedDate: Date = Date()
    @State var showDateSheet: Bool = false
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()
    @State var showTimeSheet: Bool = false
    @State var description: String = ""
    
    @StateObject var allUnitsViewModel = AllUnitsViewModel()
    
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

                    NavigationLink(value: CreateEventNavigation.createPoll) {
                        Text("Next")
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
       }
        .onAppear{
            allUnitsViewModel.fetchUnits()
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
    CreateEventView(
        path: .constant(NavigationPath.init()),
        selectedTab: .constant(Tab.createEvent)
    )
}
