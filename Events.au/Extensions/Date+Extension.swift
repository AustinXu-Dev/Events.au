//
//  Date.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

extension Date {
    func formattedDateAndMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let dayString = dateFormatter.string(from: self)
        guard let day = Int(dayString) else { return "" }
        
        // Determine the day suffix
        let suffix: String
        switch day {
        case 11, 12, 13:
            suffix = "th"
        default:
            switch day % 10 {
            case 1:
                suffix = "st"
            case 2:
                suffix = "nd"
            case 3:
                suffix = "rd"
            default:
                suffix = "th"
            }
        }
        
        // Format the day with the suffix and the month
        dateFormatter.dateFormat = "MMM"
        let monthString = dateFormatter.string(from: self)
        
        return "\(day)\(suffix) \(monthString)"
    }
    
    
    func formatDateOnly() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    func formatMonthOnly() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
    
    
    
    func formattedTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    //MARK: For displaying "DD-MM-YYYY" to "DD"
    func dayWithMonth() -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"
        
        let dateComponents = DateComponents(calendar: calendar, year: 2000, month: month)
        let monthName = monthFormatter.string(from: calendar.date(from: dateComponents)!)
        
        let dayWithOrdinal = formatter.string(from: NSNumber(value: day)) ?? "\(day)"
        
        return "\(dayWithOrdinal) \(monthName)"
    }
    
    //Converts Date String to Date Object
     func fromString(_ dateString: String, format: String = "dd-MM-yyyy") -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           return dateFormatter.date(from: dateString)
       }
   
    
    // Function to get just the date component (year, month, day)
    func strippedTime() -> Date? {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        return gregorianCalendar.startOfDay(for: self)
    }

    
    // Convert "hh:MM" string to Date
   

}

