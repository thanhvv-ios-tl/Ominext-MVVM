//
//  OMSVGImageView.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import SVGKit
import UIKit

class OMSVGImageView : UIImageView
{
    @IBInspectable var imageNamed:String = ""
    @IBInspectable var imageSize:CGSize = CGSize.zero

    override func awakeFromNib() {
        autoAssignImage()
    }

    private func autoAssignImage() {
        if imageNamed.count != 0 {
            if imageSize != CGSize.zero {
                self.image = UIImage.SVG(imageNamed, size: imageSize)
            } else {
                self.image = UIImage.SVG(imageNamed)
            }
        }
    }
}
