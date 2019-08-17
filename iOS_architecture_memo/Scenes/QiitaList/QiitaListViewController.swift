//
//  ViewController.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/15.
//  Copyright © 2019 com.komori. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class QiitaListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private lazy var viewModel = QiitaListViewModel(itemSelected: tableView.rx.itemSelected.asObservable())
    private let disposeBag = DisposeBag()
    
    static func createInstance() -> QiitaListViewController {
        let className = "QiitaListViewController"
        let storyboard = UIStoryboard(name: className, bundle: nil)
        let instance = storyboard.instantiateViewController(withIdentifier: className) as! QiitaListViewController
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "QiitaListTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "QiitaListTableViewCell")
        
        viewModel.reloadData
            .bind(to: reloadData)
            .disposed(by: disposeBag)
        
        viewModel.trantionToUserDetail
            .bind(to: trantionToUserDetail)
            .disposed(by: disposeBag)
    }
}

extension QiitaListViewController {
    private var reloadData: Binder<Void> {
        return Binder(self, binding: { (me, _) in
            me.tableView.reloadData()
        })
    }
    
    private var trantionToUserDetail: Binder<QiitaItem> {
        return Binder(self, binding: { (me, qiitaItem) in
            let viewController = QiitaDetailViewController.createInstance(qiitaItem: qiitaItem)
            me.navigationController?.pushViewController(viewController, animated: true)
        })
    }
}

extension QiitaListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaListTableViewCell", for: indexPath) as? QiitaListTableViewCell
        guard let qiitaListTableViewCell = cell else { return UITableViewCell() }
        let qiitaItem = viewModel.dataSource[indexPath.row]
        cell?.configure(qiitaItem: qiitaItem)
        return qiitaListTableViewCell
    }
}
