//
//  GetListDrugAPI.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
class GetListDrugAPI: API<[Drug]> {
    override func path() -> String {
        return "api/drugs"
    }
    
    override func method() -> HTTPMethod {
        return .get
    }
    
    override func convertObject(val: Any) -> [Drug] {
        guard let list = val as? [[String:Any]] else { fatalError()}
        
        return list.map(Drug.init)
    }
}
