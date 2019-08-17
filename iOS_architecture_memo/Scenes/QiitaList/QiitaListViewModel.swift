//
//  QiitaListViewModel.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/17.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class QiitaListViewModel {
    private let qiitaListModel: QiitaListModelProtocol
    private let disposeBag = DisposeBag()
    
    //computed values
    var dataSource: [QiitaItem] { return _dataSource.value }
    
    //values
    private let _dataSource = BehaviorRelay<[QiitaItem]>(value: [])
    
    //observables
    let reloadData: Observable<Void>
    let trantionToUserDetail: Observable<QiitaItem>
    
    init(itemSelected: Observable<IndexPath>,
         qiitaListModel: QiitaListModelProtocol = QiitaListModel()) {
        self.qiitaListModel = qiitaListModel
        
        self.reloadData = _dataSource.map { _ in }
        self.trantionToUserDetail = itemSelected
            .withLatestFrom(_dataSource) { ($0, $1) }
            .flatMap({ (indexPath, dataSource) -> Observable<QiitaItem> in
                guard indexPath.row < dataSource.count else {
                    return .empty()
                }
                return .just(dataSource[indexPath.row])
            })
        
        let fetchQiitaItemsResponse = qiitaListModel
            .fetchQiitaItems()
            .materialize()
        
        fetchQiitaItemsResponse
            .flatMap { (event) -> Observable<[QiitaItem]> in
                event.element.map(Observable.just) ?? .empty()
            }
            .bind(to: _dataSource)
            .disposed(by: disposeBag)
    }
}
