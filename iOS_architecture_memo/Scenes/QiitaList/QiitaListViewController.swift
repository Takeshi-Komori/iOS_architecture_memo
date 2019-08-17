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
    private var presenter: QiitaListPresenterInput!
    
    func inject(presenter: QiitaListPresenterInput) {
        self.presenter = presenter
    }
    
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
        presenter.viewDidLoad()
    }
}

extension QiitaListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfQiitaItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaListTableViewCell", for: indexPath) as? QiitaListTableViewCell
        guard let qiitaListTableViewCell = cell else { return UITableViewCell() }
        if let qiitaItem = presenter.item(forRow: indexPath.row) {
            qiitaListTableViewCell.configure(qiitaItem: qiitaItem)
        }
        return qiitaListTableViewCell
    }
}

extension QiitaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        //入力に対して処理を分けるなどのロジックはpresenterが受け持つ
        presenter.didSelectRow(at: indexPath)
    }
}

extension QiitaListViewController: QiitaListPresenterOutput {
    func updateQiitaItems(_ qiitaItems: [QiitaItem]) {
        tableView.reloadData()
    }
    
    func transitionToQiitaDetail(qiitaItem: QiitaItem) {
        let viewController = QiitaDetailViewController.createInstance(qiitaItem: qiitaItem)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
