//
//  HomeVC.swift
//  DemoTopics
//
//  Created by Apple on 19/09/24.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var lblNotifyText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(getNotify(notification:)), name: .google, object: nil)
    }
    @objc func getNotify(notification:Notification){
        (notification.name == .facebook) ? (self.lblNotifyText.text = "Facebook") : (self.lblNotifyText.text =  "Google")
    }
    @IBAction func btnActionObserve(_ sender: UIButton){
        let ctrl =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductVC")as! ProductVC
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
}
