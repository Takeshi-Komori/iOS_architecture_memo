//
//  SelectQiitaItemStore.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/18.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

class SelectQiitaItemStore: Store {
    static let shared = SelectQiitaItemStore(dispatcher: .shared)
    private(set) var selectedQiitaItem: QiitaItem?
    
    override func onDispatch(_ action: Action) {
        switch action {
        case .fetchQiitaItems:
            return
        case let .selectedQiitaItem(qiitaItem):
            self.selectedQiitaItem = qiitaItem
        }
        emitChange()
    }
}
