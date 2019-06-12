//
//  DrugListViewModel.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RxSwift

class DrugViewModel: BaseViewModel {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

class DrugListViewModel: BaseViewModel {
    struct Input {
        var drugs: [Drug] = []
    }
    
    struct Output {
        var needToReloadPublishSubject = PublishSubject<Void>()
        var getDrugsErrorSubject = PublishSubject<Error>()
    }
    
    var input: Input! {
        didSet {
            self.drugViewModels = self.input.drugs.map{ DrugViewModel(id: $0.id, name: $0.name) }
        }
    }
    
    var output: Output!
    
    var drugViewModels: [DrugViewModel] = [] {
        didSet {
            self.output.needToReloadPublishSubject.onNext(Void())
        }
    }
    
    let dao = DrugsDao()
    let getListDrugUC = DIContainer.shared.resolve(GetListDrugUC.self)
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
    }
    
    func loadRemoteData() {
        self.getListDrugUC.exe().subscribe(onNext: {[weak self] (drugs) in
            self?.cacheDrugs(drugs)
            self?.input.drugs = drugs
        }, onError: {[weak self] (error) in
            self?.output.getDrugsErrorSubject.onNext(error)
        }).disposed(by: self.disposeBag)
    }
    
    func loadCacheDate() {
        self.input.drugs = self.dao.getAllDrug().map{ Drug.init(entity: $0) }
    }
    
    func cacheDrugs(_ drugs: [Drug]) {
        self.dao.cacheDrugs(drugs)
    }
}

