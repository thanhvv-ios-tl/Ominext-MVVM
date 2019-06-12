//
//  OrientationManager.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit
class OrientationManager {
    static var shared = OrientationManager()

    var supportOrientation: UIInterfaceOrientationMask
    
    init() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.supportOrientation = .all
        } else {
            self.supportOrientation = .portrait
        }
    }
    
    func defaultOrientation() -> UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .all
        }
        
        return .portrait
    }
    
    func resetDefaultOrientationSupport() {
        self.supportOrientation = self.defaultOrientation()
    }
    
    func allowAllOrientation() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return
        }
        
        self.supportOrientation = .all
    }
    
    func allowLandscapeOrientation() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return
        }
        
        self.supportOrientation = .landscape
    }
}
