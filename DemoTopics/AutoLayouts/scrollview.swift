//
//  scrollview.swift
//  DemoTopics
//
//  Created by Apple on 21/09/24.
//

import UIKit

class scrollview: UIViewController,UITextFieldDelegate{

    @IBOutlet var textfield1 : UITextField!
    @IBOutlet var textfield2 : UITextField!
    @IBOutlet var textfield3 : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeboaradManager()
        textfield1.delegate = self
        textfield2.delegate = self
        textfield3.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension scrollview{
    func hideKeboaradManager(){
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        tapGesture.cancelsTouchesInView =  false
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hidekeyboard(){
        self.view.endEditing(true)
    }
}
