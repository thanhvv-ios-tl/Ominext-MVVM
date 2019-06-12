//
//  UIImageExtensions.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import SVGKit
extension UIImage {
    class func SVG(_ svgName: String, size: CGSize = .zero) -> UIImage {
        var nameImage: String = svgName
        if !svgName.contains(".svg") {
            nameImage.append(".svg")
        }

        let nameWithoutExt = svgName.replacingOccurrences(of: ".svg", with: "")
        if Bundle.main.path(forResource: nameWithoutExt, ofType: "svg") == nil {
            return UIImage()
        }

        // Load SVG image
        let svgImage = SVGKImage(named: nameImage, in: Bundle.main)

        // Set size for image
        if size != .zero {
            svgImage?.scaleToFit(inside: size)
        }
        return svgImage?.uiImage ?? UIImage()
    }
}
