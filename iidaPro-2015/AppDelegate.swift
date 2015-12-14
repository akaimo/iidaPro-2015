//
//  AppDelegate.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/14/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let categoryArray = ["普通ごみ1", "普通ごみ2", "びん・缶・ペットボトル", "ミックスペーパー", "プラスチック製容器包装", "小物金属"]
    let categoryDict = ["普通ごみ1":"normal_1",
                        "普通ごみ2":"normal_2",
                        "びん・缶・ペットボトル":"bottle",
                        "ミックスペーパー":"mixedPaper",
                        "プラスチック製容器包装":"plastic",
                        "小物金属":"bigRefuse_date"]
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if self.isFirstRun() {
            let realm = RealmController()
            realm.firstSynch()
            
            self.pushSettingView()
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func isFirstRun() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let _ = userDefaults.objectForKey("firstRunDate") {
            return false
        }
        
        userDefaults.setValue(NSDate(), forKey: "firstRunDate")
        userDefaults.synchronize()
        
        return true
    }
    
    func pushSettingView() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigation = storyboard.instantiateViewControllerWithIdentifier("Navigation") as! UINavigationController
        let setting = storyboard.instantiateViewControllerWithIdentifier("Setting") as! SettingViewController
        setting.isFirstRun = true
        
        navigation.pushViewController(setting, animated: false)
        navigation.navigationBar.barTintColor = UIColor(red: 86/255.0, green: 96/255.0, blue: 133/255.0, alpha: 1.0)
        navigation.navigationBar.tintColor = UIColor.whiteColor()
        navigation.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        self.window?.rootViewController = navigation
        self.window?.addSubview(navigation.view)
        self.window?.makeKeyAndVisible()
    }
    
}
