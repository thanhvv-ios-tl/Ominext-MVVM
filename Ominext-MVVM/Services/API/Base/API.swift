//
//  API.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
fileprivate protocol APIRequest {
    associatedtype Response
    func path() -> String
    func baseURL() -> String
    func method() -> HTTPMethod
    func params() -> [String:Any]
    func encoding() -> Alamofire.ParameterEncoding
    func header() -> Alamofire.HTTPHeaders
    func convertObject(val: Any) -> Response
}

class API<Response>: APIRequest {
    enum Environment {
        case dev
        case staging
        case product
    }

    lazy var currentEnvironment: Environment = {
        #if Dev
        return .dev
        #endif

        #if Staging
        return .staging
        #endif

        #if Product
        return .product
        #endif
    }()

    // MARK: - Request
    func request() -> Observable<Response> {
        return Observable.create({ (observer) -> Disposable in
            self.request(observer: observer)
            
            return Disposables.create()
        })
    }
    
    fileprivate func request(observer: AnyObserver<Response>) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10

        let manager = SessionManager.init(configuration: configuration)
        let url = URL.init(string: "\(self.baseURL())/\(self.path())")!
        let request = manager.request(url, method: self.method(), parameters: self.params(), encoding: self.encoding(), headers: self.header())
        request.responseJSON { (response) in
            manager.session.invalidateAndCancel()
            if let json = response.result.value as? [String:Any],
                let code = json["code"] as? Int,
                let message = json["message"] as? String {

                let e = APIError.init(method: response.request?.httpMethod ?? "GET", status: response.response?.statusCode ?? 0, params: self.params(), encoding: self.encoding(), message: message, errorCodeRaw: code)
                observer.onError(e)
                return
            }

            if let httpStatus = response.response?.statusCode, httpStatus >= 400 {
                let e = APIError.init(method: response.request?.httpMethod ?? "GET", status: httpStatus, params: self.params(), encoding: self.encoding(), message: "", errorCodeRaw: httpStatus)
                observer.onError(e)
                return
            }

            switch response.result {
            case .success(let val):
                let res = self.convertObject(val: val)
                observer.onNext(res)
                observer.onCompleted()
            case .failure(let error):
                let e = APIError.init(method: response.request?.httpMethod ?? "GET", status: response.response?.statusCode ?? 0, params: self.params(), encoding: self.encoding(), message: error.localizedDescription, errorCodeRaw: (error as NSError).code)
                observer.onError(e)
            }
        }
    }

    // MARK: - Helper
    func joinParams(_ params:[String:Any]) -> String {
        let paramKeys = params.keys
        if paramKeys.count == 0 {
            return ""
        }

        let paramsJoined = paramKeys.map { key -> String in
            let val = params[key]!
            return "\(key)=\(val)"
        }

        let urlParams = paramsJoined.joined(separator: "&")
        return "?\(urlParams)"
    }
    
    // MARK: - APIRequest
    func path() -> String {
        return ""
    }
    
    func baseURL() -> String {
        switch self.currentEnvironment {
        case .dev:
            return "https://5cff655dd691540014b0db28.mockapi.io"
        case .staging:
            return "https://api-staging.ominext.com"
        case .product:
            return "https://api-product.ominext.com"
        }
    }
    
    func method() -> HTTPMethod {
        return .get
    }
    
    func params() -> [String : Any] {
        return [:]
    }
    
    func encoding() -> ParameterEncoding {
        return URLEncoding.default
    }
    
    func header() -> HTTPHeaders {
        return ["Accept":"application/json",
                "X-Access-Token": Session.currentSession.token ?? ""]
    }
    
    func convertObject(val: Any) -> Response {
        fatalError("Method must override")
    }
}
