//
//  RealmExtensions.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
            do {
                try self.commitWrite()
            } catch {
                print("Realm error: - isInWriteTransaction")
            }
        } else {
            do {
                try self.write(block)
            } catch {
                print("Realm error: - Begin write transaction")
            }
        }
    }
}
