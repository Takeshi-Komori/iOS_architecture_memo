//
//  QiitaListViewModel.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/17.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

class QiitaListViewModel {
    private let notificationCenter: NotificationCenter
    private let model: QiitaListModelProtocol
    private(set) var dataSource: [QiitaItem] = [] {
        didSet {
            notificationCenter.post(name: NSNotification.Name("qiitaItemsUpdated"), object: nil)
        }
    }
    
    init(notificationCenter: NotificationCenter, model: QiitaListModelProtocol = QiitaListModel()) {
        self.notificationCenter = notificationCenter
        self.model = model
    }
    
    func viewDidLoad() {
        model.fetchQiitaItems { [weak self] (qiitaItems) -> (Void) in
            self?.dataSource = qiitaItems
        }
    }
}
