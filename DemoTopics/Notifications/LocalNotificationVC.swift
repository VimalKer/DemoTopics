//
//  LocalNotificationVC.swift
//  DemoTopics
//
//  Created by Apple on 19/09/24.
//

import UIKit
import UserNotifications

class NotificationCell:UITableViewCell{
    
    @IBOutlet weak var lblTitle: UILabel!
   
    var arrData:String?{
        didSet{
            self.lblTitle.text = self.arrData
        }
    }
}

class LocalNotificationVC: UIViewController {

    @IBOutlet weak var tblNotificationList: UITableView!
    
    //MARK: - Varriable Declaration
    let date = Date().addingTimeInterval(360.0)
    let notificationCenter  =  UNUserNotificationCenter.current()
    let strUUID  =  UUID().uuidString
    
    let badgeNumber  = 10
    let application = UIApplication.shared
    
    var arrData = [
    "Hello Welcome To IOS!!",
    "Welcome IOS Tutorials",
    "This is Local Notification",
    "Please Follow the Push Notification Tutorials and Also receive some Notify to complete Task",
    "Do Some English Speaking Course!!",
    "You want to receive a Job",
    "Are Done with Flutter App"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        if #available(iOS 16.0, *) {
            notificationCenter.setBadgeCount(15) { (error) in
                print(error)
            }
        } else {
            application.applicationIconBadgeNumber = 15
        }
        application.registerForRemoteNotifications()
    }
    func scheduleNotification(localNotification : LocalNotification) {
        
        //MARK: - Step - 2 Create Notification Content
        let content    =  UNMutableNotificationContent()
        content.title  =  localNotification.title
        content.body   =  localNotification.body
        content.sound  = .default
        
        //MARK: - Step - 3  Create the Notification Center Trigger
        //let trigger  = UNTimeIntervalNotificationTrigger(timeInterval: 60.0, repeats: true)
   //     let dateComponent  = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        
        let calender =  Calendar.current
        var dateComponent =   DateComponents(calendar: calender)
        dateComponent.hour = 5
        dateComponent.minute = 2
        let trigger2  = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        //MARK: - Step - 4 Create request
        let request  =  UNNotificationRequest(identifier: localNotification.identifier, content: content, trigger: trigger2)
        self.notificationCenter.add(request) { (error) in
            if error ==  nil{
                print("notification calls shortley!!")
            }
        }
     }
}
extension LocalNotificationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblNotificationList.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath)as! NotificationCell
        cell.arrData = self.arrData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scheduleNotification(localNotification: LocalNotification.init(identifier: strUUID, title: arrData[indexPath.row], body: "Welcome Message", repeats: true))
    }
}
struct LocalNotification{
    
    var identifier:String
    var title :String
    var body :String
    var repeats : Bool
}
