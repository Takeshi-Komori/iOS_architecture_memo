//
//  ActionCreator.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/18.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

final class ActionCreator {
    private let dispatcher: Dispatcher
    
    init(dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
    }
}

//MARK: - QiitaList
extension ActionCreator {
    func fetchQiitaItems() {
        QiitaItemManager.fetchQiitaItems { [weak self] (qiitaItems) -> (Void) in
            guard let qiitaItems = qiitaItems else { return }
            self?.dispatcher.dispatch(.fetchQiitaItems(qiitaItems))
        }
    }
}

//MARK: - SelectQiitaItem
extension ActionCreator {
    func selectQiitaItem(_ qiitaItem: QiitaItem) {
        dispatcher.dispatch(.selectedQiitaItem(qiitaItem))
    }
}
