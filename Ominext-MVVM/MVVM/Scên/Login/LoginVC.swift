//
//  LoginVC.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {
    // MARK: - Property
    var viewModel: LoginViewModel!
    
    // MARK: - UI Property
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        self.viewModel = LoginViewModel.init()
        
        self.config()
        self.initRx()
    }
    
    // MARK: - Config
    func config() {
        self.title = "Login"
    }
    
    func initRx() {
        self.usernameTextField.rx.text.asObservable().ignoreNil().bind(to: self.viewModel.input.username).disposed(by: self.rx_disposeBag)
        self.passwordTextField.rx.text.asObservable().ignoreNil().bind(to: self.viewModel.input.password).disposed(by: self.rx_disposeBag)
        self.signInButton.rx.tap.asObservable().bind(to: self.viewModel.input.signInButtonTap).disposed(by: self.rx_disposeBag)
        
        self.viewModel.output.loginSuccessObservable.subscribe(onNext: {[weak self] user in
            self?.handleLoginSuccess(with: user)
        }).disposed(by: self.rx_disposeBag)
        
        self.viewModel.output.loginErrorObservable.subscribe(onNext: {[weak self] error in
            self?.handleLoginFail(with: error)
        }).disposed(by: self.rx_disposeBag)
        
        self.viewModel.output.validateError.asObservable().subscribe(onNext: {[weak self] (validateError) in
            self?.handleValidateError(with: validateError)
        }).disposed(by: self.rx_disposeBag)
    }
    
    // MARK: - Handler
    func handleLoginSuccess(with user: User) {
        Session.currentSession.token = user.token
        Session.currentSession.saveSession()

        let drugVC = DrugsVC()
        let naviVC = BaseNaviVC(rootViewController: drugVC)
        self.present(naviVC, animated: true, completion: nil)
    }
    
    func handleLoginFail(with error: Error) {
        self.showAlert(title: "Complete", message: "Login fail")
    }
    
    func handleValidateError(with error: LoginValidateErrorType) {
        self.showAlert(title: "Error", message: error.rawValue.localized)
    }
}
