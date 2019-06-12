//
//  LoginAPI.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class LoginAPI: API<User> {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    override func path() -> String {
        return "api/login"
    }
    
    override func params() -> [String : Any] {
        return ["username": self.username, "password": self.password]
    }
    
    override func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
    override func method() -> HTTPMethod {
        return .post
    }
    
    override func convertObject(val: Any) -> User {
        guard let json = val as? [String:Any] else { fatalError("Error") }

        return User(json: json)
    }
}
