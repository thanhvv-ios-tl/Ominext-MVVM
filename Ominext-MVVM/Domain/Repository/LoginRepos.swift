//
//  LoginRepos.swift
//  Ominext-MVVM
//
//  Created by Thanh Vu on 6/12/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RxSwift
protocol LoginRepos {
    func login(withUsername username: String, password: String) -> Observable<User>
}
