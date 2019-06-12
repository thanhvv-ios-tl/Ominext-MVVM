//
//  RlmDrugEntity.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//
import Foundation
import RealmSwift

class RlmDrugEntity: Object {
    @objc dynamic var id: String!
    @objc dynamic var name: String!
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(drug: Drug) {
        self.init()
        self.id = drug.id
        self.name = drug.name
    }
}
