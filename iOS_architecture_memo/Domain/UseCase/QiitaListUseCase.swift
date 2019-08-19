//
//  QiitaListUseCase.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/19.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

protocol QiitaListUseCaseInputPort: class {
    func fetchQiitaItems()
    var output: QiitaListUseCaseOutputPort! { get set }
    var qiitaListGateway: QiitaListGatewayProtocol! { get set }
}

protocol QiitaListUseCaseOutputPort: class {
    func receiveQiitaItems(_ qiitaItems: [QiitaItem])
}

final class QiitaListUseCase: QiitaListUseCaseInputPort {
    var output: QiitaListUseCaseOutputPort!
    var qiitaListGateway: QiitaListGatewayProtocol!
    
    func fetchQiitaItems() {
        qiitaListGateway.fetchQiitaItems { [weak self] (qiitaItems) in
            self?.output.receiveQiitaItems(qiitaItems)
        }
    }
}
