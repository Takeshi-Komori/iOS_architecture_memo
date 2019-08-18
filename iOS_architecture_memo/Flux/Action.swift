//
//  Action.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/18.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

enum Action {
    //QiitaList
    case fetchQiitaItems([QiitaItem])
    case selectedQiitaItem(QiitaItem)
}
