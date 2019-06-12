//  THIS SOURCE CODE IS THE INTELLECTUAL PROPERTY OF TELESENSE, INC. This source
//  code cannot be copied, modified, printed, reproduced or used in any way, 
//  shape or form without prior permission from Telesense, Inc. ANY ATTEMPTS TO
//  COPY, MODIFY, PRINT, REPRODUCE OR USE THIS SOURCE CODE WITHOUT PERMISSION 
//  FROM TELESENSE, INC ARE STRICTLY PROHIBITED.
//
//  Anyone creating, updating, or viewing this source code in any way, shape
//  or form is bound by this copyright message, including Telesense, Inc 
//  employees, contractors, partners, or any other associated or non-associated
//  person, entity or a system.
//
//  Copyright 2019 Telesense, Inc., All rights reserved.
//
//  DIContainer.swift

import Foundation
import Swinject
class DIContainer {
    static let shared = DIContainer()

    var container = Container()

    init() {
        self.register()
    }

    // MARK: - Helper
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        if Thread.isMainThread {
            return self.container.resolve(serviceType)!
        } else {
            var service:Service?

            DispatchQueue.main.sync {[weak self] in
                service = self?.container.resolve(serviceType)
            }

            return service!
        }
    }

    // MARK: - Register
    func register() {
        self.registerErrorHandler()
        registerForLoginVC()
        registerForDrugsVC()
    }

    // MARK: Register
    func registerErrorHandler() {
        self.container.register(ErrorHandle.self) { r, controller in
            ErrorHandlerImp.init(controller: controller)
        }
    }

    func registerForLoginVC() {
        self.container.register(LoginRepos.self) { r in
            LoginReposImp()
        }

        self.container.register(LoginUC.self) { r in
            LoginUC(r.resolve(LoginRepos.self)!)
        }
    }
    
    func registerForDrugsVC() {
        self.container.register(ListDrugRepos.self) { r in
            ListDrugReposImp()
        }
        
        self.container.register(GetListDrugUC.self) { r in
            GetListDrugUC(r.resolve(ListDrugRepos.self)!)
        }
    }
}

extension DIContainer {
    func resolve<Service,Args1>(_ serviceType: Service.Type, _ args1: Args1) -> Service {
        if Thread.isMainThread {
            return self.container.resolve(serviceType, argument: args1)!
        } else {
            var service:Service?

            DispatchQueue.main.sync {[weak self] in
                service = self?.container.resolve(serviceType, argument: args1)
            }

            return service!
        }
    }
}
