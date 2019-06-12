//
//  ErrorHandler.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
protocol ErrorHandle {
    func handleError(error: Error)
}

class ErrorHandlerImp: ErrorHandle {
    weak var controller: BaseVC?

    init(controller: BaseVC) {
        self.controller = controller
    }

    func handleError(error: Error) {
        guard let apiError = error as? APIError else {
            return
        }

        switch apiError.errorCode {
        case .unauthorized:
            
            break
        default:
            break
        }

        if apiError.errorCode == .unknow {
            switch apiError.httpStatus {
            case 500:
                self.controller?.showAlert(title: "Common.Message.InternalServerError".localized)
                break
            default:
                break
            }
        }
    }
}
