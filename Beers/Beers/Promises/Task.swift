//
//  PromiseTest.swift
//  AccountMVP
//
//  Created by Mobile Team on 7/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

class Task<Value>: AnyTask {
    
    var promise: CompletablePromise<Value>
    var task: ((CompletablePromise<Value>) -> ())
    
    let id: String = UUID().uuidString
    
    var state: PromiseState {
        get {
            return promise.immutableSelf().state
        }
    }
    
    var isCompleted: Bool {
        get {
            return state == .Completed || state == .Canceled
        }
    }
    
    init(started: @escaping ((CompletablePromise<Value>) -> ())) {
        self.task = started
        
        promise = Promises.completable()
        promise.immutableSelf().listen { (it) in
            self.notifyChange()
        }
    }
    
    func start(queue: DispatchQueue) {
        self.promise.started()
        queue.async {
            self.task(self.promise)
        }
    }
    
    typealias Listener = ((Bool)->())
    
    private var listeners: [Listener] = []
    
    func onCompleted(_ listener: @escaping Listener) {
        listeners.append(listener)
    }
    
    private func notifyChange() {
        DispatchQueue.global(qos: .background).async {
            for listener in self.listeners {
                DispatchQueue.main.async {
                    listener(self.isCompleted)
                }
            }
        }
    }
}
