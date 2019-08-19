//
//  QiitaListGateway.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/19.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

protocol QiitaListGatewayProtocol {
    func fetchQiitaItems(completionHandler: @escaping ([QiitaItem]) -> ())
}

class QiitaListGateway: QiitaListGatewayProtocol {
    func fetchQiitaItems(completionHandler: @escaping ([QiitaItem]) -> ()) {
        QiitaItemAPIClient.fetchQiitaItems { (qiitaItems) -> (Void) in
            guard let qiitaItems = qiitaItems else { return }
            completionHandler(qiitaItems)
        }
    }
}
