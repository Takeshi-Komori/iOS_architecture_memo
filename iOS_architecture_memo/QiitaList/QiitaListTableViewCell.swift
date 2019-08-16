//
//  QiitaListTableViewCell.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/16.
//  Copyright © 2019 com.komori. All rights reserved.
//

import UIKit

class QiitaListTableViewCell: UITableViewCell {
    @IBOutlet private weak var label: UILabel!
    
    func configure(qiitaItem: QiitaItem) {
        label.text = qiitaItem.id + "\n" + qiitaItem.title
    }
}
