//
//  QiitaListStore.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/18.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

class QiitaListStore: Store {
    static let shared = QiitaListStore(dispatcher: .shared)
    private(set) var dataSource: [QiitaItem] = []
    
    override func onDispatch(_ action: Action) {
        switch action {
        case let .fetchQiitaItems(qiitaItems):
            self.dataSource = qiitaItems
        case .selectedQiitaItem:
            return
        }
        emitChange()
    }
}
