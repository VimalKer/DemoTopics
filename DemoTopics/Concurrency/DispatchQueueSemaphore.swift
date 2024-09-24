//
//  DispatchQueueSemaphore.swift
//  DemoTopics
//
//  Created by Apple on 20/09/24.
//

import UIKit

class DispatchQueueSemaphore: UIViewController {

    var arrMusics:[String] = []
    
    let semaphore  = DispatchSemaphore(value: 1)
    let queue  = DispatchQueue.global()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrMusics.removeAll()
        
        queue.async {
            print("before first wait block!")
            self.semaphore.wait()   //0 it's decrement   No Calling
            print("after first wait block!")
            let strMusic = self.downloadMusic(name: "Pyaar Kia to Nibhaan Mp3!!")
            self.arrMusics.append(strMusic)
            self.semaphore.signal()  //1 it's increment
            
          // self.semaphore.signal() // it will
        }
        
        queue.async {
            print("before second wait block!")
            self.semaphore.wait()     // 0 it's  No Calling
            print("after second wait block!")
            self.saveMusic()
            self.arrMusics.remove(at: 0)   //Thread 9: Fatal error: Index out of range  because here direct called save music after 2 second not downloaded so it will crash here
          
            //MARK: - So We use Semaphore
            self.semaphore.signal() //
        }
    }
    func downloadMusic(name :String)  -> String{
        sleep(4)
        print("\(name) has been downloaded!!")
        return name
    }
    func saveMusic(){
        sleep(2)
        print("Musics Have been saved!!")
    }

}
