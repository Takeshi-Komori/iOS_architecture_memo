//
//  ViewController.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/15.
//  Copyright © 2019 com.komori. All rights reserved.
//

import UIKit
import RxSwift

final class QiitaListViewController: UIViewController {
    //View
    @IBOutlet weak var qiitaListView: QiitaListView!
    var qiitaListRxModel: QiitaListRxModelType?
    
    private let disposeBag = DisposeBag()
    private var dataSource: [QiitaItem] = []
    
    static func createInstance() -> QiitaListViewController {
        let className = "QiitaListViewController"
        let storyboard = UIStoryboard(name: className, bundle: nil)
        let instance = storyboard.instantiateViewController(withIdentifier: className) as! QiitaListViewController
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qiitaListView.tableView.delegate = self
        qiitaListView.tableView.dataSource = self
        qiitaListView.tableView.register(UINib(nibName: "QiitaListTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "QiitaListTableViewCell")
        qiitaListRxModel?.fetchQiitaItems()
        bindQiitaRxModel()
    }
    
    private func bindQiitaRxModel() {
        qiitaListRxModel?.dataSource
            .subscribe(onNext: { qiitaItemList in
                self.dataSource = qiitaItemList
                self.qiitaListView.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}

extension QiitaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let qiitaItem = dataSource[indexPath.item]
        let viewController = QiitaDetailViewController.createInstance(qiitaItem: qiitaItem)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension QiitaListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaListTableViewCell", for: indexPath) as? QiitaListTableViewCell
        guard let qiitaListTableViewCell = cell else { return UITableViewCell() }
        let qiitaItem = dataSource[indexPath.row]
        qiitaListTableViewCell.configure(qiitaItem: qiitaItem)
        return qiitaListTableViewCell
    }
}

