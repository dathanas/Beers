//
//  TaskInterface.swift
//  AccountMVP
//
//  Created by Mobile Team on 7/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

protocol AnyTask {
    var state: PromiseState { get }
    
    var isCompleted: Bool { get }
    
    var id: String { get }
    
    func start(queue: DispatchQueue)
    
    typealias Listener = ((Bool)->())
    
    func onCompleted(_ listener: @escaping Listener) 
}
