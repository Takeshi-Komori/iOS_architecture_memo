//
//  ViewController.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/15.
//  Copyright © 2019 com.komori. All rights reserved.
//

import UIKit

final class QiitaListViewController: UIViewController {
    //View
    @IBOutlet weak var qiitaListView: QiitaListView!
    
    //Model
    var qiitaListModel: QiitaListModel? {
        didSet {
            registerModel()
        }
    }
    
    deinit {
        qiitaListModel?.notificationCenter.removeObserver(self)
    }
    
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
        qiitaListModel?.fetchQiitaItems()
    }
    
    func registerModel() {
        //ControllerがModelの更新通知を監視
        qiitaListModel?.notificationCenter.addObserver(forName: NSNotification.Name("qiitaItemsUpdated"),
                                                       object: nil,
                                                       queue: nil,
                                                       using:
            { [weak self] (notification) in
                //更新を受け取ったらどのように更新するかをViewに指示する
                self?.qiitaListView.tableView.reloadData()
        })
    }
}

extension QiitaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = qiitaListModel?.dataSource else { return }
        let qiitaItem = dataSource[indexPath.item]
        let viewController = QiitaDetailViewController.createInstance(qiitaItem: qiitaItem)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension QiitaListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = qiitaListModel?.dataSource else { return 0 }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaListTableViewCell", for: indexPath) as? QiitaListTableViewCell
        guard let qiitaListTableViewCell = cell else { return UITableViewCell() }
        guard let dataSource = qiitaListModel?.dataSource else { return UITableViewCell() }
        let qiitaItem = dataSource[indexPath.row]
        qiitaListTableViewCell.configure(qiitaItem: qiitaItem)
        return qiitaListTableViewCell
    }
}

