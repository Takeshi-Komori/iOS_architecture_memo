//
//  Store.swift
//  iOS_architecture_memo
//
//  Created by 小森武史 on 2019/08/18.
//  Copyright © 2019 com.komori. All rights reserved.
//

import Foundation

typealias Subscription = NSObjectProtocol

class Store {
    private enum NotificationName {
        static let storeChanged = Notification.Name("store-changed")
    }
    private lazy var dispatchToken: DispatchToken = {
        return dispatcher.register(callback: { (action) in self.onDispatch(action) })
    }()
    private let notificationCenter: NotificationCenter
    private let dispatcher: Dispatcher
    
    deinit {
        dispatcher.unregister(dispatchToken)
    }
    
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        self.notificationCenter = NotificationCenter()
        _ = dispatchToken
    }
    
    func onDispatch(_ action: Action) {
        fatalError("must override")
    }
    
    final func emitChange() {
        notificationCenter.post(name: NotificationName.storeChanged, object: nil)
    }
    
    final func addListener(callback: @escaping () -> ()) -> Subscription {
        let using: (Notification) -> () = { notification in
            if notification.name == NotificationName.storeChanged {
                callback()
            }
        }
        return notificationCenter.addObserver(forName: NotificationName.storeChanged,
                                              object: nil,
                                              queue: nil,
                                              using: using)
    }
    
    final func removeListener(_ subscription: Subscription) {
        notificationCenter.removeObserver(subscription)
    }
}
