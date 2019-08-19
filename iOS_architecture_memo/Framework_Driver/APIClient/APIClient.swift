//
//  APIManager.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/15.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    static func request(urlStr: String, completionHandler: @escaping (String?, Error?) -> (Void)) {
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        Alamofire.request(request).responseString { (response) in
            switch(response.result) {
            case .success(_):
                print("success reuest:::\(String(describing: response.request))")
                guard let resultStr = response.result.value else {
                    return
                }
                completionHandler(resultStr, nil)
            case .failure(let error):
                print("failure request:::\(String(describing: response.request))")
                completionHandler(nil ,error)
            }
        }
    }
}
