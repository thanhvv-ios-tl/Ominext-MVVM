//
//  DateExtensions.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
extension Date {
    public var calendar: Calendar {
        return NSCalendar.current
    }
    
    public var era: Int {
        return calendar.component(.era, from: self)
    }
    
    public var quarter: Int {
        return calendar.component(.quarter, from: self)
    }
    
    public var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }
    
    public var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }
    
    public var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.year = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }
    
    public var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.month = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }
    
    public var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.day = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }
    
    public var weekday: Int {
        get {
            return calendar.component(.weekday, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second], from: self)
            component.weekday = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }
    
    public var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.hour = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }
    
    public var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.minute = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }
    
    public var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.second = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }
    
    public var nanosecond: Int {
        get {
            return calendar.component(.nanosecond, from: self)
        }
        set {
            if let date = calendar.date(bySetting: .nanosecond, value: newValue, of: self) {
                self = date
            }
        }
    }
    
    public var millisecond: Int {
        get {
            return calendar.component(.nanosecond, from: self) / 1000000
        }
        set {
            let ns = newValue * 1000000
            if let date = calendar.date(bySetting: .nanosecond, value: ns, of: self) {
                self = date
            }
        }
    }
    
    public var isInFuture: Bool {
        return self > Date()
    }
    
    public var isInPast: Bool {
        return self < Date()
    }
    
    public var isInToday: Bool {
        return calendar.isDateInToday(self)
    }
    
    public var isInYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }
    
    public var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }
    
    public var isInWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }
    
    public var isInWeekday: Bool {
        return !calendar.isDateInWeekend(self)
    }
    
    public var iso8601String: String {
        return DateUtils.shared.stringFromDate(self, format: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
    
    public var isoStringBeginDay: String {
        return DateUtils.shared.stringFromDate(self, format: "yyyy-MM-dd'T'00:00:00Z")
    }
    
    public var isoStringMidDay: String {
        return DateUtils.shared.stringFromDate(self, format: "yyyy-MM-dd'T'12:00:00Z")
    }
    
    public var isoStringEndDay: String {
        return DateUtils.shared.stringFromDate(self, format: "yyyy-MM-dd'T'23:59:59Z")
    }

    public var longDateFormat: String {
        return DateUtils.shared.stringFromDate(self, format: "MMM DD, yyyy, HH:mm:ss a")
    }
    
    public var timeZone: TimeZone {
        return calendar.timeZone
    }
    
    public var unixTimestamp: Double {
        return timeIntervalSince1970
    }
    
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(Double(milliseconds) / Double(1000)))
    }
    
    init(milliseconds: Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }

    public var shortString: String {
        return DateUtils.shared.stringFromDate(self, format: "DD MMM - HH:mm aa")
    }

    func getElapsedInterval() -> String {
        var componentsToNow = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: Date())

        if componentsToNow.year! > 0 {
            return componentsToNow.year! == 1 ? "\(componentsToNow.year!) year ago" : "\(componentsToNow.year!) years ago"
        }

        if componentsToNow.month! > 0 {
            return componentsToNow.month! == 1 ? "\(componentsToNow.month!) month ago" : "\(componentsToNow.month!) months ago"
        }

        if componentsToNow.day! > 0 {
            return componentsToNow.day! == 1 ? "\(componentsToNow.day!) day ago" : "\(componentsToNow.day!) days ago"
        }

        if componentsToNow.hour! > 0 {
            return componentsToNow.hour! == 1 ? "\(componentsToNow.hour!) hour ago" : "\(componentsToNow.hour!) hours ago"
        }

        if componentsToNow.minute! > 0 {
            return componentsToNow.minute! == 1 ? "\(componentsToNow.minute!) minute ago" : "\(componentsToNow.minute!) minutes ago"
        }

        return "a moment ago"
    }
}
