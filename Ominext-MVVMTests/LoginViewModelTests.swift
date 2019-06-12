//
//  LoginViewModelTests.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
@testable import Ominext_MVVM

class LoginViewModelTest: XCTestCase {
    var sut: LoginViewModel!
    override func setUp() {
        sut = LoginViewModel()
    }
    
    func testBothEmpty() {
        sut.input.username.onNext("")
        sut.input.password.onNext("")
        
        let expect = expectation(description: "Test with username and pass empty")
        
        sut.input.signInButtonTap.onNext(Void())
        sut.output.validateError.asObservable()
            .subscribe(onNext: { (error) in
                XCTAssertEqual(error, LoginValidateErrorType.allFieldNeedFillAll)
                expect.fulfill()
            }).disposed(by: self.rx_disposeBag)
        
        wait(for: [expect], timeout: 30.0)
    }
    
    func testOnlyUserNameEmpty() {
        sut.input.username.onNext("")
        sut.input.password.onNext("Value")
        
        let expect = expectation(description: "Test with only username empty")
        
        sut.input.signInButtonTap.onNext(Void())
        sut.output.validateError.asObservable()
            .subscribe(onNext: { (error) in
                XCTAssertEqual(error, LoginValidateErrorType.allFieldNeedFillAll)
                expect.fulfill()
            }).disposed(by: self.rx_disposeBag)
        
        wait(for: [expect], timeout: 30.0)
    }
    
    func testOnlyPasswordEmpty() {
        sut.input.username.onNext("")
        sut.input.password.onNext("Value")
        
        let expect = expectation(description: "Test with only password empty")
        
        sut.input.signInButtonTap.onNext(Void())
        sut.output.validateError.asObservable()
            .subscribe(onNext: { (error) in
                XCTAssertEqual(error, LoginValidateErrorType.allFieldNeedFillAll)
                expect.fulfill()
            }).disposed(by: self.rx_disposeBag)
        
        wait(for: [expect], timeout: 30.0)
    }
    
    func testLoginSuccess() {
        sut.input.username.onNext("Username")
        sut.input.password.onNext("pass")
        
        let expect = expectation(description: "Test pass")
        
        sut.input.signInButtonTap.onNext(Void())
        sut.output.loginSuccessObservable.asObservable()
            .subscribe(onNext: { (user) in
                XCTAssertNotNil(user)
                expect.fulfill()
            }).disposed(by: self.rx_disposeBag)
        
        wait(for: [expect], timeout: 30.0)
    }
}
