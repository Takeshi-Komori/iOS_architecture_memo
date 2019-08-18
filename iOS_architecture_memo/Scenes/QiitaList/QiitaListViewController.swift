//
//  ViewController.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/15.
//  Copyright © 2019 com.komori. All rights reserved.
//

import UIKit

final class QiitaListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let qiitaListStore: QiitaListStore = .shared
    private let selectQiitaItemStore: SelectQiitaItemStore = .shared
    private let actionCreator: ActionCreator = .init()
    
    private lazy var reloadSubscription: Subscription = { [weak self] in
        return qiitaListStore.addListener {
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }()
    
    private lazy var transitionToDetailQiitaItemSubscription: Subscription = { [weak self] in
        return selectQiitaItemStore.addListener {
            guard let qiitaItem = self?.selectQiitaItemStore.selectedQiitaItem else { return }
            let viewController = QiitaDetailViewController.createInstance(qiitaItem: qiitaItem)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }()
    
    static func createInstance() -> QiitaListViewController {
        let className = "QiitaListViewController"
        let storyboard = UIStoryboard(name: className, bundle: nil)
        let instance = storyboard.instantiateViewController(withIdentifier: className) as! QiitaListViewController
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "QiitaListTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "QiitaListTableViewCell")
        _ = reloadSubscription
        _ = transitionToDetailQiitaItemSubscription
        actionCreator.fetchQiitaItems()
    }
}

extension QiitaListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qiitaListStore.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaListTableViewCell", for: indexPath) as? QiitaListTableViewCell
        guard let qiitaListTableViewCell = cell else { return UITableViewCell() }
        let qiitaItem = qiitaListStore.dataSource[indexPath.row]
        qiitaListTableViewCell.configure(qiitaItem: qiitaItem)
        return qiitaListTableViewCell
    }
}

extension QiitaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let qiitaItem = qiitaListStore.dataSource[indexPath.row]
        actionCreator.selectQiitaItem(qiitaItem)
    }
}
