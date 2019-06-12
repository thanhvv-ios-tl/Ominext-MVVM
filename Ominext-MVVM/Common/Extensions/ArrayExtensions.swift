//
//  ArrayExtensions.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import CocoaLumberjack
extension Array {
    subscript (safe index: Int) -> Element? {
        get {
            return (0 <= index && index < count) ? self[index] : nil
        }
        set (value) {
            if value == nil {
                return
            }

            if !(count > index) {
                DDLogWarn("WARN: index:\(index) is out of range, so ignored. (array:\(self))")
                return
            }

            self[index] = value!
        }
    }
}
