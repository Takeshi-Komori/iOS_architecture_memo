//
//  QiitaListModel.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/16.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

protocol QiitaListModelInput {
    func fetchQiitaItems(completionHandler: @escaping ([QiitaItem]) -> (Void))
}

class QiitaListModel: QiitaListModelInput {
    func fetchQiitaItems(completionHandler: @escaping ([QiitaItem]) -> (Void)) {
        QiitaItemManager.fetchQiitaItems { (qiitaItems) -> (Void) in
            guard let qiitaItems = qiitaItems else { return }
            completionHandler(qiitaItems)
        }
    }
}
