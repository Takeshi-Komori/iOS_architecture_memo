//
//  QiitaItemManager.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/15.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

class QiitaItemManager {
    static func fetchQiitaItems(completionHandler: @escaping ([QiitaItem]?) -> (Void)) {
        APIClient.request(urlStr: "https://qiita.com/api/v2/items") { (str, err) -> (Void) in
            if let err = err {
                print(err)
                completionHandler(nil)
                return
            }
            guard let str = str else {
                completionHandler(nil)
                return
            }
            do {
                let data = str.data(using: .utf8)!
                let qiitaItems = try JSONDecoder().decode([QiitaItem].self, from: data)
                completionHandler(qiitaItems)
            } catch let err {
                print(err)
                completionHandler(nil)
                return
            }
        }
    }
}


