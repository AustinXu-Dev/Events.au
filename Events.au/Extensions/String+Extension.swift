//
//  String+Extension.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 08/07/2024.
//

import Foundation
 
extension String {
    func toDate(withFormat format: String = "dd-MM-yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Set timezone to UTC
        return dateFormatter.date(from: self)
    }
}
