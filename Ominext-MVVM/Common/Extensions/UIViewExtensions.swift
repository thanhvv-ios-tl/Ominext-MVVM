//
//  UIViewExtensions.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    @IBInspectable var borderWidth: CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            self.layer.borderColor = newValue?.cgColor
        }
        
        get {
            guard let cgcolor = self.layer.borderColor else { return nil }
            return UIColor.init(cgColor: cgcolor)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
        
        get {
            return self.layer.cornerRadius
        }
    }

    func fitSuperviewConstraint(edgeInset: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let superview = self.superview!
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: edgeInset.top).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: edgeInset.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -edgeInset.right).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -edgeInset.bottom).isActive = true
    }

    static func loadView(fromNib nibName: String) -> UIView? {
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.last as? UIView
    }

    func heightConstraint() -> NSLayoutConstraint? {
        var constraint: NSLayoutConstraint?
        self.constraints.forEach { (c) in
            if (c.firstItem as? UIView) == self && c.firstAttribute == NSLayoutConstraint.Attribute.height {
                constraint = c            }
        }

        return constraint
    }
}
