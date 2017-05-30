//
//  AppDelegate.swift
//  SceneManageSample
//
//  Created by HasegawaYasuo on 2017/05/28.
//  Copyright © 2017年 HasegawaYasuo. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var main:MainViewCtl!
    var historyBtn: UIButton!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        main = MainViewCtl()
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.rootViewController = main
        window!.makeKeyAndVisible()
        
        // set up scene controll
        SceneManager.shared.setUp(Scene.TopViewCtl.rawValue, viewCtl:main)
        
        // history back btn for debug
        historyBtn = UIButton()
        
        historyBtn.frame = CGRect(x: 10, y: 10, width: 150, height: 30)
        historyBtn.tag = 0
        historyBtn.backgroundColor = UIColor.red
        historyBtn.setTitle("HISTORY BACK", for: .normal)
        historyBtn.setTitleColor(UIColor.white, for: .normal)
        historyBtn.addTarget(self, action: #selector(AppDelegate.onTouch(sender:)), for: .touchUpInside)
        window!.addSubview(historyBtn)
        historyBtn.isHidden = true
        
        // observe "SceneManager.shared.history" propery change and update history button visibility,
        _ = SceneManager.shared.history.observeNext {
            history in
            print(">>>> history:\(history?.count)")
            self.historyBtn.isHidden = (history?.count)! <= 0
        }
        
        return true
    }
    
    internal func onTouch(sender: UIButton) {
        SceneManager.shared.historyBack()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
