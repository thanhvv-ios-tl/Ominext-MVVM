//
//  OMLabel.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit

class OMLabel: UILabel {
    @IBInspectable var localizationKey: String = ""
    override func awakeFromNib() {
        self.localization()
        self.adjustFont()
    }
    
    func localization() {
        if self.localizationKey.count != 0 {
            self.text = localizationKey.localized
        }
    }
    
    func adjustFont() {
        guard let currentFont = self.font else {
            return
        }
        
        let currentFontSize = currentFont.pointSize
        if currentFont.familyName == UIFont.systemFont(ofSize: 12).familyName {
            self.font = UIFont.fontWithSize(currentFontSize, fontWeight: self.fontWeightFromSystemFont(currentFont))
        }
    }

    func fontWeightFromSystemFont(_ font: UIFont) -> UIFont.Weight {
        let fontName = font.fontName

        if fontName.hasSuffix("-Bold") {
            return UIFont.Weight.bold
        }

        if fontName.hasSuffix("-Semibold") {
            return UIFont.Weight.semibold
        }
        
        if fontName.hasSuffix("-Medium") {
            return UIFont.Weight.medium
        }

        return UIFont.Weight.regular
    }
}
