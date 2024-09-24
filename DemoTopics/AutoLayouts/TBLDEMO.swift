//
//  TBLDEMO.swift
//  DemoTopics
//
//  Created by Apple on 20/09/24.
//

import UIKit

class TBLDEMO: UIViewController {
    
    @IBOutlet weak var tblDemo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
extension TBLDEMO:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDemo.dequeueReusableCell(withIdentifier: "cellDATA", for: indexPath)as! cellDATA
        cell.lblTitle.text = "Vitor Tom"
        cell.LblData.text = "Address:  ISOCON"
        cell.lblSubTitle.text = "AHMEDABAD"
        return cell
    }
}
class cellDATA:UITableViewCell{
    
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var LblData: UILabel!
    
}
