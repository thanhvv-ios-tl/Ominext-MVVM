//
//  DateUtils.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
class DateUtils {
    static let shared = DateUtils()
    
    func dateFromString(_ string: String, format: String) -> Date? {
        let formatter = formatterForFormat(format: format)
        return formatter.date(from: string)
    }

    func dateFromISO8601(_ string: String) -> Date? {
        let formatter = formatterForFormat(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        return formatter.date(from: string)
    }

    func dateFromMilisecond(_ milisecond: Int64) -> Date {
        return Date.init(milliseconds: milisecond)
    }

    func stringFromDate(_ date: Date, format: String) -> String {
        let formatter = formatterForFormat(format: format)
        return formatter.string(from: date)
    }
    
    // MAKR: - Private func
    private func formatterForFormat(format: String) -> DateFormatter {
        var formatter: DateFormatter
        formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
}
