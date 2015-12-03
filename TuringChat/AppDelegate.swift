//
//  AppDelegate.swift
//  TuringChat
//
//  Created by Junne on 9/16/15.
//  Copyright (c) 2015 Junne. All rights reserved.
//

import UIKit
import Parse

let api_key = "2836ffb78226e81dcd0c2a81117c5c2a"
let api_url = "http://www.tuling123.com/openapi/api"
let userId = "junnehello"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId("oUKLlUDcXczJ5KeYwm4SGCjisbxqtjuFxCUgYMAK", clientKey: "0yf166y3CN27ywRDqveMWVfbkixYo7FdwiF5ijoK")
//        let query = PFQuery(className: "Messages")
//        query.orderByAscending("sentDate")
//        query.findObjectsInBackgroundWithBlock { (objects,error) -> Void in
//            for object in objects!  {
//                let incoming:Bool = object.objectForKey("incoming") as! Bool
//                let text:String = object.objectForKey("text") as! String
//                let sentDate:NSDate = object.objectForKey("sentDate") as! NSDate
//                print("\(object.objectId!)\n\(incoming)\n\(text)\n\(sentDate)")
//            }
//        }
        
        
//        let ChatVC:ChatViewController = ChatViewController()
//        ChatVC.title = "Hello"
//        UINavigationBar.appearance().tintColor = UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0)
//        UINavigationBar.appearance().barTintColor = UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0)
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//        UIApplication.sharedApplication().statusBarStyle = .LightContent
//        let navigationVC:UINavigationController = UINavigationController(rootViewController: ChatVC)
//        let frame = UIScreen.mainScreen().bounds
//        window = UIWindow(frame: frame)
//        window!.rootViewController = navigationVC
//        window!.makeKeyAndVisible()
//        return true
        
        
        let welcomeVC:WelcomeViewController = WelcomeViewController()
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        
        let frame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frame)
        
        window!.rootViewController = welcomeVC
        window!.makeKeyAndVisible()
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


}

