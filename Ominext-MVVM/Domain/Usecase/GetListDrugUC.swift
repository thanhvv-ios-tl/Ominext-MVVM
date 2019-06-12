//
//  GetListDrugUC.swift
//  Ominext-MVVM
//
//  Created by Thanh Vu on 6/12/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RxSwift
class GetListDrugUC {
    var repos: ListDrugRepos
    
    init(_ repos: ListDrugRepos) {
        self.repos = repos
    }
    
    func exe() -> Observable<[Drug]> {
        return self.repos.getListDrug()
    }
}
