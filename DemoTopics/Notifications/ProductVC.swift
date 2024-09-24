//
//  ProductVC.swift
//  DemoTopics
//
//  Created by Apple on 19/09/24.
//

import UIKit

class ProductVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func btnActionPost(_ sender: UIButton){
        NotificationCenter.default.post(name: .google, object: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
extension Notification.Name{
    static let facebook =  Notification.Name("Facebook")
    static let google  =   Notification.Name("Google")
}
