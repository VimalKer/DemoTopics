//
//  AppDelegate.swift
//  DemoTopics
//
//  Created by Apple on 19/09/24.
//

import UIKit
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate{

    var window: UIWindow?
    let notificationCenter  =  UNUserNotificationCenter.current()
    var IS_Granted = false;

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
      // self.localNotificationPermission()
        
    
        //Install this Pod
        //IQkeyboardManager.shared.enable = true
        //IQkeyboardManager.shared.enableAutoToolbar  = false
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK: - Step 1 permisstion Ask to user - second step in LocalNotification.VC
    func localNotificationPermission(){
        let center  = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.sound,.badge]) { granted, error in
            if error !=  nil{
                print("Local Notification Permisstion Granted!!\(granted)")
            }
            if !granted{
                if #available(iOS 13.0.0, *) {
                    self.openSettings()
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge,.sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    /*
    @available(iOS 13.0.0, *)
    func requestAuthorization() async throws{
        try? await notificationCenter.requestAuthorization(options: [.alert,.badge,.sound])
        await getCurrentSettings()
    }
    @available(iOS 13.0.0, *)
    func getCurrentSettings() async {
        let currentSettings = await notificationCenter.notificationSettings()
        IS_Granted  = (currentSettings.authorizationStatus == .authorized)
    }
     */
    @available(iOS 13.0.0, *)
    func openSettings(){
        if let  url =  URL(string: UIApplication.openSettingsURLString){
            if UIApplication.shared.canOpenURL(url){
                Task{
                    await UIApplication.shared.open(url)
                }
            }
        }
    }
   
}

