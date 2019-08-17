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
    private let notificationCenter = NotificationCenter()
    private lazy var viewModel = QiitaListViewModel(notificationCenter: notificationCenter)
    
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
        notificationCenter.addObserver(self,
                                       selector: #selector(refreshDataSource),
                                       name: NSNotification.Name(rawValue: "qiitaItemsUpdated"),
                                       object: nil)
        viewModel.viewDidLoad()
    }
}

extension QiitaListViewController {
    //Observableな更新
    @objc func refreshDataSource() {
        tableView.reloadData()
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
        qiitaListTableViewCell.configure(qiitaItem: qiitaItem)
        return qiitaListTableViewCell
    }
}

extension QiitaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let qiitaItem = viewModel.dataSource[indexPath.row]
        let viewController = QiitaDetailViewController.createInstance(qiitaItem: qiitaItem)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
