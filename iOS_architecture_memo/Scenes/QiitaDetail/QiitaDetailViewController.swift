//
//  QiitaDetailViewController.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/15.
//  Copyright © 2019 com.komori. All rights reserved.
//

import UIKit

final class QiitaDetailViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    private var qiitaItem: QiitaItem!
    
    static func createInstance(qiitaItem: QiitaItem) -> QiitaDetailViewController {
        let className = "QiitaDetailViewController"
        let storyboard = UIStoryboard(name: className, bundle: nil)
        let instance = storyboard.instantiateViewController(withIdentifier: className) as! QiitaDetailViewController
        instance.qiitaItem = qiitaItem
        return instance
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = qiitaItem.title
        bodyLabel.text = qiitaItem.body
    }

}
