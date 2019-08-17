//
//  QiitaListModel.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/16.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation
import RxSwift

protocol QiitaListModelProtocol {
    func fetchQiitaItems() -> Observable<[QiitaItem]>
}

class QiitaListModel: QiitaListModelProtocol {
    func fetchQiitaItems() -> Observable<[QiitaItem]> {
        return Observable.create({ [weak self] (observer) -> Disposable in
            QiitaItemManager.fetchQiitaItems(completionHandler: { (qiitaItems) -> (Void) in
                guard let qiitaItems = qiitaItems else {
                    observer.onError(APIError.noResponse)
                    return
                }
                observer.onNext(qiitaItems)
            })
            return Disposables.create()
        })
    }
}
