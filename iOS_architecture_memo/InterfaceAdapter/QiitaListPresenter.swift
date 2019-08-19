//
//  QiitaListPresenter.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/19.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

protocol QiitaListPresenterInput {
    func viewDidLoad()
    var qiitaListPresenterOutput: QiitaListPresenterOutput? { get set }
}

protocol QiitaListPresenterOutput {
    func updateQiitaItems(_ qiitaItems: [QiitaItem])
}

class QiitaListPresenter: QiitaListPresenterInput {
    private weak var useCase: QiitaListUseCaseInputPort!
    var qiitaListPresenterOutput: QiitaListPresenterOutput?
    
    init(useCase: QiitaListUseCaseInputPort) {
        self.useCase = useCase
        self.useCase.output = self
    }
    
    func viewDidLoad() {
        //InterfaceAdapter(Presenter) → UseCase
        useCase.fetchQiitaItems()
    }
}

extension QiitaListPresenter: QiitaListUseCaseOutputPort {
    func receiveQiitaItems(_ qiitaItems: [QiitaItem]) {
        qiitaListPresenterOutput?.updateQiitaItems(qiitaItems)
    }
}
