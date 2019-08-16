//
//  QiitaListView.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/16.
//  Copyright © 2019 com.komori. All rights reserved.
//

import UIKit

class QiitaListView: UIView {
    @IBOutlet weak var tableView: UITableView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    func loadNib(){
        let view = Bundle.main.loadNibNamed("QiitaListView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
