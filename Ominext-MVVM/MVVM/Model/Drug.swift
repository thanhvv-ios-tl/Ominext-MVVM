//
//  Drug.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation

class Drug {
    var id: String!
    var name: String!
    
    init(json: [String:Any]) {
        self.id = json["id"] as? String
        self.name = json["name"] as? String
    }
    
    init(entity: RlmDrugEntity) {
        self.id = entity.id
        self.name = entity.name
    }
}
