//
//  QiitaListModel.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/16.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol QiitaListRxModelType {
    var dataSource: PublishRelay<[QiitaItem]> { get }
    func fetchQiitaItems()
}

class QiitaListRxModel: QiitaListRxModelType {
    
    var dataSource = PublishRelay<[QiitaItem]>()
    
    func fetchQiitaItems() {
        QiitaItemManager.fetchQiitaItems { [weak self] (qiitaItems) -> (Void) in
            guard let qiitaItems = qiitaItems else { return }
            self?.dataSource.accept(qiitaItems)
        }
    }
}
