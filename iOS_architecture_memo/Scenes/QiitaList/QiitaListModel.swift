//
//  QiitaListModel.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/16.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation
import UIKit

class QiitaListModel: NSObject {
    let notificationCenter = NotificationCenter()
    
    var dataSource: [QiitaItem] = [] {
        didSet {
            notificationCenter.post(name: NSNotification.Name(rawValue: "qiitaItemsUpdated"), object: nil)
        }
    }
    
    func fetchQiitaItems() {
        QiitaItemManager.getItems { [weak self] (qiitaItems) -> (Void) in
            guard let weakSelf = self else { return }
            guard let qiitaItems = qiitaItems else { return }
            weakSelf.dataSource = qiitaItems
        }
    }
}
