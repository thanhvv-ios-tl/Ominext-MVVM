//
//  DrugListViewModelTests.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
@testable import Ominext_MVVM

class DrugListViewModelTests: XCTestCase {
    var sut: DrugListViewModel!
    override func setUp() {
        sut = DrugListViewModel()
    }
    
    func testNeedToReloadPublishSubjectEvent() {
        let d1 = Drug.init(json: ["id": "1", "name": "name"])
        let d2 = Drug.init(json: ["id": "2", "name": "name 2"])
        let expect = expectation(description: "")
        
        sut.output.needToReloadPublishSubject.asObservable()
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe(onNext: { (_) in
                XCTAssertTrue(true)
                expect.fulfill()
            }).disposed(by: self.rx_disposeBag)
        
        sut.input.drugs = [d1, d2]
        
        wait(for: [expect], timeout: 30.0)
    }
}

