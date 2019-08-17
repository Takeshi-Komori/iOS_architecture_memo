//
//  QiitaListModel.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/17.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

protocol QiitaListModelProtocol {
    func fetchQiitaItems(completionHandler: @escaping ([QiitaItem]) -> (Void))
}

class QiitaListModel: QiitaListModelProtocol {
    func fetchQiitaItems(completionHandler: @escaping ([QiitaItem]) -> (Void)) {
        QiitaItemManager.fetchQiitaItems { (qiitaItems) -> (Void) in
            guard let qiitaItems = qiitaItems else { return }
            completionHandler(qiitaItems)
        }
    }
}
