//
//  BaseVC.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController, ErrorHandle {
    // MARK: - Property
    var viewWillAppeared: Bool = false
    var viewDidAppeared: Bool = false

    var errorHandle: ErrorHandle!

    var currentPage: Int = 1
    var isLoading: Bool = false
    var isStopLoading: Bool = false
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.baseConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !viewWillAppeared {
            viewWillAppeared = true
            self.viewWillFirstAppear()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !viewDidAppeared {
            viewDidAppeared = true
            self.viewDidFirstAppear()
        }
    }
    
    func viewWillFirstAppear() {
        
    }
    
    func viewDidFirstAppear() {
        
    }
    
    // MARK: - Config
    func baseConfig() {
        self.errorHandle = ErrorHandlerImp(controller: self)
    }

    // MARK: - Error handle
    func handleError(error: Error) {
        self.errorHandle.handleError(error: error)
    }

    // MARK: - Orientation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return OrientationManager.shared.supportOrientation
    }

    // MARK: - Helper

    // MARK: - Alert
    func showAlert(title: String = "", message: String = "", titleButtons: [String] = ["Common.OK".localized], action: ((Int) -> Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        titleButtons.forEach { (titleButton) in
            let index = titleButtons.firstIndex(of: titleButton)!
            let alertAction = UIAlertAction.init(title: titleButton, style: UIAlertAction.Style.default, handler: { (_) in
                action?(index)
            })

            alert.addAction(alertAction)
        }

        self.present(alert, animated: true, completion: nil)
    }
}
