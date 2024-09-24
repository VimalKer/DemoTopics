//
//  DispatchGroupNotify.swift
//  DemoTopics
//
//  Created by Apple on 20/09/24.
//

import UIKit

class DispatchGroupNotify: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //notifyDispatchGroup()
        syncWaitingGroup()
    }
}
//MARK: -  DISPATCH GROUP to notify when all task will be completed
//It will be Asynchronos
extension DispatchGroupNotify{
    
    func notifyDispatchGroup(){
        
        let group = DispatchGroup()
        let queue  =  DispatchQueue(label: "com.queue.technoios")
        let someQueue  = DispatchQueue(label: "com.apple.developer")
        
        queue.async(group: group){
            for _ in 0...25{
                print("Queue :- Task One Running")
            }
        }
        
        queue.async(group: group){
            for _ in 0...15{
                print("Queue :- Task Two Running")
            }
        }
        someQueue.async(group : group){
            for _ in 0...45{
                print("SomeQueue :- Task Two Running")
            }
        }
        group.notify(queue: DispatchQueue.main) {
            print("All Jobs/Tasks Has been Completed")
        }
    }
    //MARK: - Notify + wait Method called if complete in time than it will complete or its notify like task is pending
    func syncWaitingGroup(){
        
        let group = DispatchGroup()
        let queue  =  DispatchQueue.global(qos: .userInitiated)
        
        queue.async(group: group){
            print("Start Job 1")
            Thread.sleep(until: Date().addingTimeInterval(10))
            print("End Job 1")
        }
        queue.async(group: group){
            print("Start Job 2")
            Thread.sleep(until: Date().addingTimeInterval(2))
            print("End Job 2")
        }
        
        queue.async(group: group){
            print("Start Job 3")
            Thread.sleep(until: Date().addingTimeInterval(14))
            print("End Job 3")
        }
        
        queue.async(group: group){
            print("Start Job 4")
            Thread.sleep(until: Date().addingTimeInterval(7))
            print("End Job 4")
        }
        
        queue.async(group: group){
            print("Start Job 5")
            Thread.sleep(until: Date().addingTimeInterval(1))
            print("End Job 5")
        }
       
        if group.wait(timeout: .now() + 15.0) == .timedOut{
            print("I got tried of waiting")
        }else{
            print("All Jobs/Tasks Has been Completed")
        }
        
    }
    
}
