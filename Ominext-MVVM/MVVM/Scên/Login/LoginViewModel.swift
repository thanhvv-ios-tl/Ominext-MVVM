//
//  LoginViewModel.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//
import Foundation
import RxSwift

enum LoginValidateErrorType: String {
    case allFieldNeedFillAll = "LoginVC.Message.UsernamePasswordIsRequire"
}

class LoginViewModel: BaseViewModel {
    struct Input {
        var username = PublishSubject<String>().asObserver()
        var password = PublishSubject<String>().asObserver()
        var signInButtonTap = PublishSubject<Void>().asObserver()
    }
    
    struct Output {
        let loginSuccessObservable = PublishSubject<User>()
        let loginErrorObservable = PublishSubject<Error>()
        let validateError = PublishSubject<LoginValidateErrorType>()
    }
    
    var input: Input!
    var output: Output!
    let loginUc: LoginUC = DIContainer.shared.resolve(LoginUC.self)
    
    init(input: Input = Input()) {
        super.init()
        self.input = input
        self.output = Output()
        self.initRx()
    }
    
    func initRx() {
        let usernamePasswordObservable = Observable.combineLatest(self.input.username.asObservable(), self.input.password.asObservable())
        
        self.input.signInButtonTap
            .observeOn(SerialDispatchQueueScheduler(qos: .background))
            .withLatestFrom(usernamePasswordObservable).flatMap({[weak self] (username, password) -> Observable<(String,String)> in
                let error = !(username.count != 0 && password.count != 0)
                if error {
                    self?.output.validateError.onNext(LoginValidateErrorType.allFieldNeedFillAll)
                    return Observable.empty()
                } else {
                    return Observable.just((username, password))
                }
                
            }).flatMapLatest {[weak self] (username, password) -> Observable<User> in
                guard let `self` = self else { return Observable.empty() }
                
                return self.loginUc.exe(username: username, password: password)
            }.subscribe(onNext: {[weak self] (user) in
                self?.output.loginSuccessObservable.onNext(user)
                }, onError: {[weak self] (error) in
                    self?.output.loginErrorObservable.onNext(error)
            }).disposed(by: self.disposeBag)
    }
}
