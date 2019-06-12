//
//  DrugsVC.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit

class DrugsVC: BaseVC {
    // MARK: - Property
    var viewModel: DrugListViewModel!
    var drugViewModels: [DrugViewModel] = []
    
    // MARK: - UI Property
    @IBOutlet weak var drugsTableView: UITableView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = DrugListViewModel()
        self.config()
        self.initRx()
    }
    
    override func viewWillFirstAppear() {
        super.viewWillFirstAppear()
        
        self.viewModel.loadCacheDate()
        self.viewModel.loadRemoteData()
    }
    
    // MARK: - Config
    func config() {
        self.title = "Drugs"
        
        self.configTableView()
    }
    
    func initRx() {
        self.viewModel.output.needToReloadPublishSubject.asObservable().subscribe(onNext: {[weak self] (_) in
            self?.drugViewModels = self?.viewModel.drugViewModels ?? []
            self?.drugsTableView.reloadData()
        }).disposed(by: self.rx_disposeBag)
    }
    
    func configTableView() {
        self.drugsTableView.delegate = self
        self.drugsTableView.dataSource = self
        self.drugsTableView.register(UINib(nibName: "DrugCell", bundle: nil), forCellReuseIdentifier: "DrugCell")
        
        self.drugsTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DrugsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drugViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrugCell") as! DrugCell
        let vm = self.drugViewModels[indexPath.row]
        cell.bind(viewModel: vm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
