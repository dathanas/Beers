//
//  PromiseHandler.swift
//  AccountMVP
//
//  Created by Mobile Team on 7/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

class TaskQueue {
    private var promises: [AnyTask] = []
    
    let taskLimit: Int
    
    private var currentQueue = -1
    
    var runningTaskCount: Int {
        get {
            return promises.filter { (it) -> Bool in
                 it.state == .Started
            }.count
        }
    }
    
    private var queues: [DispatchQueue] = []
    
    init(taskLimit: Int) {
        self.taskLimit = taskLimit
        for n in 1...taskLimit {
            queues.append(DispatchQueue(label: "task_queue_\(n)"))
        }
    }
    
    func submit<V, T : Task<V>>(task: T) {
        promises.append(task)
        advanceIfNeeded()
    }
    
    func advanceIfNeeded() {
        if promises.count > 0 {
            if runningTaskCount <= taskLimit {
                let nextTask = promises.filter { (it) -> Bool in
                    it.state == .NotStarted || it.state == .Waiting
                }.first
                start(task: nextTask)
            }
        }
    }
    
    private func availableQueue() -> DispatchQueue {
        currentQueue += 1
        if currentQueue == taskLimit {
            currentQueue = 0
            return queues[currentQueue]
        } else {
            return queues[currentQueue]
        }
    }
    
    private func start(task: AnyTask?) {
        task?.onCompleted({ (it) in
            if it {
                self.didComplete(task: task)
            }
        })
        task?.start(queue: availableQueue())
    }
    
    private func didComplete(task: AnyTask?) {
        promises.removeAll { (it) -> Bool in
            it.id == task?.id
        }
        advanceIfNeeded()
    }
}
