//
//  BaseNaviVC.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit

class BaseNaviVC: UINavigationController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? OrientationManager.shared.defaultOrientation()
    }
}
