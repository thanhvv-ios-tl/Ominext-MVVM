//
//  FIRDatabase.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import FirebaseDatabase
import RxSwift

protocol FirDatabaseEncodable {
    
    /// The key of the location that generated this FIRDataSnapshot.
    var firKey: String? { get set }
    
    init(snapshot: DataSnapshot)
}

class FIRDatabase<T> {
    func observe<T: FirDatabaseEncodable>(eventType: DataEventType) -> Observable<T> {
        return Observable.create { (observer) -> Disposable in
            self.firRef().observe(eventType) { (snapshot) in
                observer.onNext(snapshot)
            }
            
            return Disposables.create()
        }.map(T.init).observeOn(QueueManager.shared.serialSchedule)
    }
    
    func firRef() -> DatabaseReference {
        fatalError()
    }
    
    func firQuery() -> DatabaseQuery {
        let query = self.firRef()
        return query
    }
}
