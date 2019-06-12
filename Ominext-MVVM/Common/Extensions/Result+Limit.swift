//
//  PHAsset+Limit.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func get <T: Object> (offset: Int, limit: Int ) -> Array<T> {
        //create variables
        var lim = 0 // how much to take
        var off = 0 // start from
        var l: Array<T> = Array<T>() // results list
        
        //check indexes
        if off<=offset && offset<self.count - 1 {
            off = offset
        }
        
        if offset >= self.count - 1 {
            return l
        }
        
        if limit > self.count - offset {
            lim = self.count - offset
        } else {
            lim = limit
        }
        
        //do slicing
        let max = off + lim
        for i in off..<max {
            if let element = self.reversed()[i] as? T {
                l.append(element)
            }
        }
        
        //results
        return l
    }
}
