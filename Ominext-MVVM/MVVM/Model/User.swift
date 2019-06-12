//
//  User.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation

class User {
    var username: String!
    var token: String!
    
    init(json: [String: Any]) {
        self.username = json["username"] as? String
        self.token = json["token"] as? String
    }
}
