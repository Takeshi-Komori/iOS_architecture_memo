//
//  QiitaListPresenter.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/16.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

protocol QiitaListPresenterInput {
    var numberOfQiitaItems: Int { get }
    func item(forRow row: Int) -> QiitaItem?
    func didSelectRow(at indexPath: IndexPath)
    func fetchQiitaItems()
}

protocol QiitaListPresenterOutput: class {
    func transitionToQiitaDetail(qiitaItem: QiitaItem)
    func updateQiitaItems(_ qiitaItems: [QiitaItem])
}

class QiitaListPresenter: QiitaListPresenterInput {
    private(set) var dataSource: [QiitaItem] = []
    private weak var view: QiitaListPresenterOutput!
    private var model: QiitaListModelInput!
    
    init(view: QiitaListPresenterOutput, model: QiitaListModelInput) {
        self.view = view //右のviewにControllerが入る
        self.model = model
    }
    
    var numberOfQiitaItems: Int {
        return dataSource.count
    }
    
    func item(forRow row: Int) -> QiitaItem? {
        guard row < dataSource.count else { return nil }
        return dataSource[row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let qiitaItem = item(forRow: indexPath.row) else { return }
        view.transitionToQiitaDetail(qiitaItem: qiitaItem)
    }
    
    func fetchQiitaItems() {
        model.fetchQiitaItems { [weak self] (qiitaItems) -> (Void) in
            self?.dataSource = qiitaItems
            self?.view.updateQiitaItems(qiitaItems)
        }
    }
}
