//
//  APIError.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import Alamofire

enum OMErrorCode: Int {
    case unknow = -1
    case success = 0

    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case timeout = 408
    case cancel = -999
    case unsupportedURL = -1002
    case cannotFindHost = -1003
}

extension OMErrorCode {
    init(systemErrorCode: Int) {
        switch systemErrorCode {
        case URLError.Code.timedOut.rawValue:
            self = OMErrorCode.timeout
        case URLError.Code.cancelled.rawValue:
            self = OMErrorCode.cancel
        case URLError.Code.unsupportedURL.rawValue:
            self = OMErrorCode.unsupportedURL
        case URLError.Code.cannotFindHost.rawValue:
            self = OMErrorCode.cannotFindHost
        default:
            self = OMErrorCode.unknow
        }
    }
}

class APIError: Error {
    var method: String?
    var httpStatus: Int = 0
    var params: [String:Any]?
    var encoding: ParameterEncoding = URLEncoding.default
    var message: String?
    var errorCode: OMErrorCode = OMErrorCode.unknow
    
    init(method: String, status: Int, params: [String:Any]?, encoding: ParameterEncoding = URLEncoding.default, message: String?, errorCodeRaw: Int = -1) {
        self.method = method
        self.httpStatus = status
        self.params = params
        self.encoding = encoding
        self.message = message
        self.errorCode = OMErrorCode.init(rawValue: errorCodeRaw) ?? OMErrorCode.init(systemErrorCode: errorCodeRaw)
    }
}
