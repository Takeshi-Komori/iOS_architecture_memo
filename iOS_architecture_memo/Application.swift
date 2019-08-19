//
//  Application.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/19.
//  Copyright © 2019 com.komori. All rights reserved.
//

import UIKit

class Application {
    static let shared = Application()
    private init() {}
    
    //ユースケースを公開プロパティとして保持
    private(set) var useCase: QiitaListUseCase!
    
    func configure(window: UIWindow) {
        buildLayer()
        
        let viewController = QiitaListViewController.createInstance()
        let rootViewController = UINavigationController(rootViewController: viewController)
        window.rootViewController = rootViewController
        
        //今回のサンプルでは、QiitaListViewControllerだけ適用
        let useCase: QiitaListUseCase! = Application.shared.useCase
        let presenter = QiitaListPresenter(useCase: useCase)
        useCase.output = presenter
        viewController.inject(presenter: presenter)
    }
    
    private func buildLayer() {
        useCase = QiitaListUseCase()
        
        let qiitaListGateway = QiitaListGateway()
        useCase.qiitaListGateway = qiitaListGateway
    }
}
