//
//  OMSVGButton.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit
class OMSVGButton : OMButton
{
    @IBInspectable var imageNamed:String = ""
    @IBInspectable var imageSize:CGSize = CGSize.zero

    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoAssignImage()
    }

    private func autoAssignImage() {
        if imageNamed.count != 0 {
            if imageSize != CGSize.zero {
                self.setImage(UIImage.SVG(imageNamed, size: imageSize).withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                self.setImage(UIImage.SVG(imageNamed).withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
}
