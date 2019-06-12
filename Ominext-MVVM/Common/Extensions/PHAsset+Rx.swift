//
//  PHAsset+Rx.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Photos

enum PHAssetErrors: Error {
    case denied
    case authorized
}

extension PHAssetErrors: CustomStringConvertible {
    var description: String {
        switch self {
        case .denied: return "ACCESS_DENIED_FOR_CAMERAROLL".localized
        case .authorized: return "Authorized".localized
        }
    }
}

extension Reactive where Base: PHAsset {
    func authorizationStatus() -> Observable<PHAuthorizationStatus> {
        return Observable.create { observable in
            observable.onNext(PHPhotoLibrary.authorizationStatus())
            observable.onCompleted()
            return Disposables.create()
        }
    }
    
    /// Get asset URL
    func getURL() -> Observable<URL?> {
        return self.authorizationStatus().flatMap { status -> Observable<URL?> in
            if status == PHAuthorizationStatus.authorized {
                return Observable.create { observable in
                    var taskContentEditing: PHContentEditingInputRequestID?
                    var taskImageRequest: PHImageRequestID?
                    
                    if self.base.mediaType == PHAssetMediaType.image {
                        let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
                        options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                            return true
                        }
                        
                        taskContentEditing = self.base.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput, _) -> Void in
                            observable.onNext(contentEditingInput?.fullSizeImageURL)
                            observable.onCompleted()
                        })
                        
                    } else if self.base.mediaType == PHAssetMediaType.video {
                        let options: PHVideoRequestOptions = PHVideoRequestOptions()
                        options.version = .original
                        taskImageRequest = PHImageManager.default().requestAVAsset(forVideo: self.base, options: options, resultHandler: {(asset, _, _) -> Void in
                            if let urlAsset = asset as? AVURLAsset {
                                observable.onNext(urlAsset.url)
                            } else {
                                observable.onNext(nil)
                            }
                            observable.onCompleted()
                        })
                    } else {
                        fatalError("not handle type: \(self.base.mediaType)")
                    }
                    return Disposables.create {
                        if let task = taskContentEditing {
                            self.base.cancelContentEditingInputRequest(task)
                        }
                        if let task = taskImageRequest {
                            PHImageManager.default().cancelImageRequest(task)
                        }
                    }
                }
            } else {
                return Observable.error(PHAssetErrors.denied)
            }
        }
    }
    
    //
    func getSize() -> Observable<Int64?> {
        return self.authorizationStatus().flatMap { status -> Observable<Int64?> in
            if status == PHAuthorizationStatus.authorized {
                return Observable.create { observable in
                    var taskImageRequest: PHImageRequestID?
                    
                    if self.base.mediaType == PHAssetMediaType.image {
                        let options: PHImageRequestOptions = PHImageRequestOptions()
                        options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
                        options.isSynchronous = false
                        options.isNetworkAccessAllowed = true
                        
                        taskImageRequest = PHImageManager.default().requestImageData(for: self.base, options: options) { (data, _, _, _) in
                            if let `size` = (data as? NSData)?.length {
                                observable.onNext(Int64(size))
                            } else {
                                observable.onNext(nil)
                            }
                            observable.onCompleted()
                        }
                        
                    } else if self.base.mediaType == PHAssetMediaType.video {
                        let resources = PHAssetResource.assetResources(for: self.base)
                        var sizeOnDisk: Int64? = 0
                        
                        if let resource = resources.first, let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong {
                            sizeOnDisk = Int64(bitPattern: UInt64(unsignedInt64))
                            observable.onNext(sizeOnDisk)
                            observable.onCompleted()
                        } else {
                            let options: PHVideoRequestOptions = PHVideoRequestOptions()
                            options.version = .original
                            PHImageManager.default().requestAVAsset(forVideo: self.base, options: options, resultHandler: { (avAsset, _, _) in
                                if avAsset == nil {
                                    observable.onNext(nil)
                                    
                                    return
                                }
                                
                                let avURLAsset = avAsset as! AVURLAsset
                                let url = avURLAsset.url
                                
                                let keys: Set<URLResourceKey> = [.fileSizeKey]
                                if let resourceValues = try? url.resourceValues(forKeys: keys) {
                                    if let fileSize = resourceValues.fileSize {
                                        observable.onNext(Int64(fileSize))
                                    }
                                } else {
                                    observable.onNext(nil)
                                }
                                observable.onCompleted()
                            })}
                    } else {
                        fatalError("not handle type: \(self.base.mediaType)")
                    }
                    return Disposables.create {
                        if let task = taskImageRequest {
                            PHImageManager.default().cancelImageRequest(task)
                        }
                    }
                }
            } else {
                return Observable.error(PHAssetErrors.denied)
            }
        }
    }
}
