//
//  Concurrency.swift
//  DemoTopics
//
//  Created by Apple on 19/09/24.
//

import UIKit

class Concurrency: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
       // Concurrency
        //MARK: - Concurrency
       // THREAD          TASKS           ORDERS
//        Serial      +     Sync     ->     Order,
//        Serial      +     Async    ->     Order
//        Concurrent  +     Sync     ->     Order
//        Concurrent  +     Async    ->     UnOrder
        
        queueTesting()
    }
    func queueTesting(){
        
        //MARK: - Serial Queue /THREAD
       // let myQueue  = DispatchQueue(label: "This is Serial Queue")
        
        
        //MARK: - Concurrent Queue /THREAD
        let myQueue  = DispatchQueue(label: "This is Serial Queue", attributes: .concurrent)
        
        
        /*
        //MARK: - Sync TASK
        //One Thread
        myQueue.sync{
            print("Task 1 IS STARTED")
            //do some work here
            for index in 1...5{
                print("\(index) [TASK 1] times 5 is \(index * 5)")
            }
            print("Task 1 IS FINISHED")
        }
        
        //Second Thread
        myQueue.sync{
            print("Task 2 IS STARTED")
            //do some work here
//            for index in 1...5{
//                print("\(index) [TASK 2] times 5 is \(index * 5)")
//            }
            print("Task 2 IS FINISHED")
        }
        
        //Third Thread
        myQueue.sync{
            print("Task 3 IS STARTED")
            //do some work here
            for index in 1...25{
                print("\(index) [TASK 3] times 5 is \(index * 5)")
            }
            print("Task 3 IS FINISHED")
        }
        
        //Fourth Thread
        myQueue.sync{
            print("Task 4 IS STARTED")
            //do some work here
//            for index in 1...20{
//                print("\(index) [TASK 3] times 5 is \(index * 5)")
//            }
            print("Task 4 IS FINISHED")
        }
        */
        
       
        //MARK: - Async TASKS
        //One Thread
        myQueue.async{
            print("Task 1 IS STARTED")
            //do some work here
            for index in 1...5{
                print("\(index) [TASK 1] times 5 is \(index * 5)")
            }
            print("Task 1 IS FINISHED")
        }
        
        //Fifth Thread
        myQueue.async{
            print("Task 6 IS STARTED")
            //do some work here
            for index in 1...4{
                print("\(index) [TASK 6] times 5 is \(index * 5)")
            }
            print("Task 6 IS FINISHED")
        }

        
        //Second Thread
        myQueue.async{
            print("Task 2 IS STARTED")
            //do some work here
//            for index in 1...5{
//                print("\(index) [TASK 1] times 5 is \(index * 5)")
//            }
            print("Task 2 IS FINISHED")
        }
         
        //Fifth Thread
        myQueue.async{
            print("Task 5 IS STARTED")
            //do some work here
            for index in 1...55{
                print("\(index) [TASK 5] times 5 is \(index * 5)")
            }
            print("Task 5 IS FINISHED")
        }
        
         //Third Thread
         myQueue.async{
             print("Task 3 IS STARTED")
             //do some work here
             for index in 1...25{
                 print("\(index) [TASK 3] times 5 is \(index * 5)")
             }
             print("Task 3 IS FINISHED")
         }
         
         //Fourth Thread
         myQueue.async{
             print("Task 4 IS STARTED")
             //do some work here
 //            for index in 1...20{
 //                print("\(index) [TASK 3] times 5 is \(index * 5)")
 //            }
             print("Task 4 IS FINISHED")
         }
         
       
    }
    
}
