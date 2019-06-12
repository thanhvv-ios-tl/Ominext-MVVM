//
//  ListDrugReposImp.swift
//  Ominext-MVVM
//
//  Created by Thanh Vu on 6/12/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RxSwift

class ListDrugReposImp: ListDrugRepos {
    func getListDrug() -> Observable<[Drug]> {
        return GetListDrugAPI().request()
    }
}
