//
//  AppUtils.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import CoreFoundation
import LocalAuthentication
import RxSwift
import UIKit

class AppUtils {
    static let shared = AppUtils()

    var versionUpdate: String?

    static let disposeBag: DisposeBag = DisposeBag()

    static func checkVersionLessThan(_ currentVersion: String, _ storeVersion: String) -> Bool {
        if storeVersion.compare(currentVersion, options: .numeric) == .orderedDescending {
            return true
        }
        return false
    }

    /// Function open an url in browser
    ///
    /// - Parameter url: url will open.
    static func openURL(_ url: String) {
        if url.count == 0 {
            return
        }
        let urlOpen: URL = URL(string: url)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(urlOpen, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(urlOpen)
        }
    }

    static func openURL(url: URL?) {
        if url == nil {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url!)
        }
    }

    static func isNilOrEmpty(value: String?) -> Bool {
        guard let string = value else {
            return true
        }

        return string.trimmingCharacters(in: .whitespaces) == ""
    }

    static func getStatusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    static func getSafeAreaBottomHeight() -> CGFloat {
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            return window.safeAreaInsets.bottom
        } else {
            return 0
        }
    }

    static func getSafeAreaTopHeight() -> CGFloat {
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            return window.safeAreaInsets.top
        } else {
            return 0
        }
    }

    static func getSafeAreaLeftWidth() -> CGFloat {
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            return window.safeAreaInsets.left
        } else {
            return 0
        }
    }

    static func getSafeAreaRightWidth() -> CGFloat {
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            return window.safeAreaInsets.right
        } else {
            return 0
        }
    }

    static func makeCall(with phoneNumber: String, _ completionHandler: @escaping () -> Void) {
        guard phoneNumber.count > 0, let url = URL(string: "tel://" + phoneNumber) else {
            completionHandler()
            return
        }

        if phoneNumber.count > 0 && UIApplication.shared.canOpenURL(url) {
            self.openURL(url: url)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completionHandler()
        }
    }

    static func displayFileSize(filesize: Int64) -> String {
        if filesize < 2 {
            return String(format: "%ldbyte", filesize)
        }
        let unit: Int = 1024
        if filesize < unit {
            // bytes
            return String(format: "%ldbytes", filesize)
        }
        let kbSize = Int(ceil(Float(filesize) / Float(unit)))
        if kbSize < unit {
            // kb
            return String(format: "%ldKB", kbSize)
        } else {
            // mb
            let mbSizeInt = Int(ceil(10 * Float(filesize) / Float(unit) / Float(unit)))
            //            let mbSizeDouble = Double(mbSizeInt / 10)
            let mbSizeDouble: Float = Float(mbSizeInt) / Float(10)
            return String(format: "%.1fMB", mbSizeDouble)
        }
    }

    static func resizeImage(image: UIImage, targetHeight: CGFloat) -> UIImage {
        // Get current image size
        let size = image.size

        // Compute scaled, new size
        let heightRatio = targetHeight / size.height
        let newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Create new image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Return new image
        return newImage!
    }

    static func imageTinted(_ image: UIImage?, _ color: UIColor) -> UIImage? {
        let rect  = CGRect(x: 0.0, y: 0.0, width: image?.size.width ?? 0.0, height: image?.size.height ?? 0.0)
        UIGraphicsBeginImageContextWithOptions(image?.size ?? CGSize.zero, false, image?.scale ?? 2.0)
        color.set()
        UIRectFill(rect)
        image?.draw(in: rect, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        let tinted = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tinted
    }

    static func bundleVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }

    static func bundleVersionString() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
}
