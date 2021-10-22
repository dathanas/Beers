//
//  PromiseHandler.swift
//  AccountMVP
//
//  Created by Mobile Team on 7/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

class TaskView<Value> {
    var promises: [Task<Value>] = []
    
    func submit(task: Task<Value>) {
        promises.append(task)
    }
}
