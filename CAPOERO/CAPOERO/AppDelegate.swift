//
//  AppDelegate.swift
//  test
//
//  Created by 田中厳貴 on 2015/06/11.
//  Copyright (c) 2015年 田中厳貴. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let ud = NSUserDefaults.standardUserDefaults()
    var window: UIWindow?
    var money: Int = 1000;
//    var collection = Array(count: 21, repeatedValue: 0);
    var collection2 = Array(count: 7, repeatedValue: Array(count: 10, repeatedValue: 0))
    var photo = Array(count: 40, repeatedValue: 0)
    var mychara: Int = 0;
    var mymusic: Int = 0;
    var cnt : Int = 0;
    var myUserDafault:NSUserDefaults = NSUserDefaults()
    var plus = Array(count: 7, repeatedValue: Array(count: 10, repeatedValue: 1))
    var cplus = Array(count: 7, repeatedValue: Array(count: 10, repeatedValue: 1))
    var stagenum: Int = 1;
    var clear: Int = 0;
    var stamina: Int = 0
    var timer = NSTimer()
    let MAX = [0,8,8,9,9,2,1]
    var nowsetting: Int = 0
    let genre_list = [1,2,2,1,1,1,4,5,2,4,6,3,1,1,1,3,1,4,2,4,4,1,5,1,6,2,1,1,5,6,5,3,3,5,4,4,2]
    var nowx:CGFloat = 0
    var nowy:CGFloat = 0
    var stagecnt: Int = 0
    var timecnt: Int = 63
/* 
    1:Lock
    2:Pop
    3:Break
    4:Hiphop
    5:Jazzhiphop
    6:Waack
*/
    
    func plus_stamina(){
        if stamina < 10{
            stamina++
            ud.setObject(stamina, forKey: "STAMINA")
            ud.synchronize()
        }
        print(stamina)
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
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

