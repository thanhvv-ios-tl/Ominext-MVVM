//
//  DrugsDao.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation

class DrugsDao: RealmDao<RlmDrugEntity> {
    func getAllDrug() -> [RlmDrugEntity] {
        guard let results = try? self.findAll(RlmDrugEntity.self) else {
            return []
        }
        
        return Array(results)
    }
    
    func cacheDrugs(_ drugs: [Drug]) {
        let entities = drugs.map(RlmDrugEntity.init)
        self.removeOldDrugs()
        try! self.createObjects(entities)
    }
    
    private func removeOldDrugs() {
        try? self.deleteObjects(RlmDrugEntity.self)
    }
}
