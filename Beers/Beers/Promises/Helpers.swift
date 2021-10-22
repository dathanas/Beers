//
//  Helpers.swift
//  AccountMVP
//
//  Created by Mobile Team on 7/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

func __test__() {
//    let p1 = getValue(forID: 0)
//    let p2 = getValue(forID: 1)
//
//    DispatchQueue(label: "testQueue").async {
//        while true {
//            print("----------------------")
//            print(p1.value, p1.state)
//            print(p2.value, p2.state)
//            print("----------------------")
//        }
//    }
    
    
    let queue = TaskQueue(taskLimit: 5)
    
    for n in 0...100 {
        let task = Task<Int>{ (promise) in
            print("Task created \(n)")
            promise.didComplete(with: n)
        }

        queue.submit(task: task)
    }
    
}

func getValue(forID id: Int) -> Promise<Int> {
    let completablePromise: CompletablePromise<Int> = Promises.completable()
    
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
        let result =  id * 2 + 10
        
        DispatchQueue.main.async {
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            completablePromise.didComplete(with: result)
        }
    }

    return completablePromise.immutableSelf()
}
