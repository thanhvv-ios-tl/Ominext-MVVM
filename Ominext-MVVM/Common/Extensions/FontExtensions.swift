//
//  FontExtensions.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func fontWithSize(_ size: CGFloat, fontWeight: UIFont.Weight = UIFont.Weight.regular) -> UIFont {
        switch fontWeight {
        case .regular:
            return self.regularFont(withSize: size)
        case .medium:
            return self.mediumFont(withSize: size)
        case .bold:
            return self.boldFont(withSize: size)
        case .semibold:
            return self.semiboldFont(withSize: size)
        default:
            return self.regularFont(withSize: size)
        }
    }
    
    private static func regularFont(withSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    private static func mediumFont(withSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    private static func boldFont(withSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    private static func semiboldFont(withSize size: CGFloat) -> UIFont {
        return UIFont.fontWithSize(size, fontWeight: .semibold)
    }
}
