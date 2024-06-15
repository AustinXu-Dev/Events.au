//
//  Date.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 09/06/2024.
//

import Foundation

extension Date {
    func formattedDate() -> String {
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
    
    func formattedTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
