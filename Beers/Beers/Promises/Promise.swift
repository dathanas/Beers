//
//  Promises.swift
//  AccountMVP
//
//  Created by Mobile Team on 7/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

enum PromiseState {
    case NotStarted, Waiting, Started, Completed, Canceled
}

class Promise<Value> {
    fileprivate var _value: Value? {
        didSet {
            notifyChange()
        }
    }
    var value: Value? {
        get {
            return _value
        }
    }
    
    fileprivate var _state: PromiseState = .NotStarted {
        didSet {
            notifyChange()
        }
    }
    
    var state: PromiseState {
        get {
            return _state
        }
    }
    
    fileprivate init() {
        // nothing
    }
    
    typealias Listener = ((Promise<Value>)->())
    
    private var listeners: [Listener] = []
    
    func listen(_ listener: @escaping Listener) {
        listeners.append(listener)
    }
    
    private func notifyChange() {
        DispatchQueue.global(qos: .background).async {
            for listener in self.listeners {
                DispatchQueue.main.async {
                    listener(self)
                }
            }
        }
    }
}

class CompletablePromise<Value> {
    private var promise: Promise<Value>
    
    fileprivate init(_ promise: Promise<Value>) {
        self.promise = promise
    }
    
    func notStarted() {
        promise._state = .NotStarted
    }
    
    func waiting() {
        promise._state = .Waiting
    }
    
    func started() {
        promise._state = .Started
    }
    
    func canceled() {
        promise._state = .Canceled
    }
    
    func didComplete(with value: Value?) {
        promise._value = value
        promise._state = .Completed
    }
    
    func immutableSelf() -> Promise<Value> {
        return self.promise
    }
}

class Promises {
    public static func completable<V>() -> CompletablePromise<V> {
        let promise = Promise<V>()
        return CompletablePromise(promise)
        
    }
}
