//
//  AppDelegate.swift
//  MapViewTest
//
//  Created by lostin1 on 2015. 3. 17..
//  Copyright (c) 2015년 lostin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        var singleton:SOSingleton = SOSingleton.getSharedInstance
        var error:NSError?
        let docDirectories:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let pathToFile = docDirectories[0] as String + "setting.plist"
        
        let fileExist = NSFileManager.defaultManager().fileExistsAtPath(pathToFile)
        if fileExist == false { //화일이 존재하지 않으면 화일을 생성하고 화일에 내용을 저장한다.
            var dic2serialize = Dictionary<String, AnyObject>()
        
            dic2serialize["longtitude"] = singleton.longtitude
            dic2serialize["latitude"] = singleton.latitude
        
            var settingData:NSData = NSPropertyListSerialization.dataWithPropertyList(dic2serialize, format: NSPropertyListFormat.XMLFormat_v1_0, options: 0, error: &error)!
            var fileWrite:Bool = settingData.writeToFile(pathToFile, atomically: true)
        
            if fileWrite == false {
                println("setting Data 쓰기 에러, error \(error?.localizedDescription)")
            }
        }
        else { //화일이 존재하면 화일을 읽는다.
            var format:UnsafeMutablePointer<NSPropertyListFormat> = UnsafeMutablePointer()
            var plistData = NSData(contentsOfFile: pathToFile)
            let property:Dictionary<String, AnyObject> = NSPropertyListSerialization.propertyListWithData(plistData!, options: NSPropertyListReadOptions.allZeros, format: format, error: &error) as Dictionary
            singleton.longtitude = property["longtitude"] as? NSNumber
            singleton.latitude = property["latitude"] as? NSNumber
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
        var singleton:SOSingleton = SOSingleton.getSharedInstance
        var error:NSError?
        let docDirectories:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let pathToFile = docDirectories[0] as String + "setting.plist"
        
        let fileExist = NSFileManager.defaultManager().fileExistsAtPath(pathToFile)
        var dic2serialize = Dictionary<String, AnyObject>()
        
        dic2serialize["longtitude"] = singleton.longtitude
        dic2serialize["latitude"] = singleton.latitude
        
        var settingData:NSData = NSPropertyListSerialization.dataWithPropertyList(dic2serialize, format: NSPropertyListFormat.XMLFormat_v1_0, options: 0, error: &error)!
        var fileWrite:Bool = settingData.writeToFile(pathToFile, atomically: true)
        
        if fileWrite == false {
            println("setting Data 쓰기 에러, error \(error?.localizedDescription)")
        }
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

