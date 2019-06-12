//
//  LoginUC.swift
//  Ominext-MVVM
//
//  Created by Thanh Vu on 6/12/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RxSwift
class LoginUC {
    var repos: LoginRepos
    
    init(_ repos: LoginRepos) {
        self.repos = repos
    }
    
    func exe(username: String, password: String) -> Observable<User> {
        return self.repos.login(withUsername: username, password: password)
    }
}
