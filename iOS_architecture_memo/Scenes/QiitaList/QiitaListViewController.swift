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
    private var dataSource: [QiitaItem] = []
    private let cellReuseIdentifier = "QiitaListTableViewCell"
    
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
        tableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: cellReuseIdentifier)
        
        QiitaItemManager.getItems { [weak self] (qiitaItems) -> (Void) in
            guard let weakSelf = self else { return }
            guard let qiitaItems = qiitaItems else { return }
            weakSelf.dataSource = qiitaItems
            weakSelf.tableView.reloadData()
        }
    }
}

extension QiitaListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? QiitaListTableViewCell
        guard let qiitaListTableViewCell = cell else { return UITableViewCell() }
        let qiitaItem = dataSource[indexPath.row]
        qiitaListTableViewCell.configure(qiitaItem: qiitaItem)
        return qiitaListTableViewCell
    }
}

extension QiitaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let qiitaItem = dataSource[indexPath.item]
        let viewController = QiitaDetailViewController.createInstance(qiitaItem: qiitaItem)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

