//
//  Session.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation

class Session {
    var token: String?

    static var currentSession: Session = {
        let session = Session()

        return session
    }()

    private init() {
        self.reloadSession()
    }

    func reloadSession() {
        let userDefaults = UserDefaults.standard
        token = userDefaults.string(forKey: "__token__")
    }

    func saveSession() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.token, forKey: "__token__")
        userDefaults.synchronize()
    }

    func clear() {
        self.token = nil
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "__token__")

        userDefaults.synchronize()
    }
}
