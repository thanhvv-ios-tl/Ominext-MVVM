//
//  StringExtensions.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    var dateISO8601: Date? {
        return DateUtils.shared.dateFromISO8601(self)
    }

    var dateFromTimestamp: Date? {
        guard let milisecond = Int64(self) else { return nil }
        return DateUtils.shared.dateFromMilisecond(milisecond)
    }
}
