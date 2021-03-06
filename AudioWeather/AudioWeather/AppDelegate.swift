//
//  AppDelegate.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/16/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var group: DispatchGroup?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Set global appearance of navigation
        UIApplication.shared.statusBarStyle = .lightContent
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: UIControlState.normal)
        UINavigationBar.appearance().tintColor = UIColor.white

        // Prepare for background fetch
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        // Listen for weather updates for background fetch
        NotificationCenter.default.addObserver(self, selector: #selector(weatherUpdated), name: .weatherNotification, object: nil)
        
        // Add local notification handling to notify user of new data
        // TODO: Add onboarding view.
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound];
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        return true
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
        
        // Refresh weather data
        WeatherLoader().refresh()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Support for background fetch
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Use a dispatch group so that we can wait for the data updated notification
        group = DispatchGroup()
        group?.enter()
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            WeatherLoader().refresh()
        }
        
        group?.wait()
        group = nil
        
        // Data fetch complete
        completionHandler(.newData)
    }

    func weatherUpdated() {
        // Received notification of data update
        
        // Post local notification of weather data updated
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = "Weather data updated!"
                content.body = WeatherLoader().location
                content.sound = UNNotificationSound.default()
                
                // Notify user
                let identifier = "UYLLocalNotification"
                let request = UNNotificationRequest(identifier: identifier,
                                                    content: content, trigger: nil)
                center.add(request, withCompletionHandler: { (error) in
                    if error != nil {
                        // Something went wrong
                    }
                    center.removeAllPendingNotificationRequests()
                })
            }
        }
        group?.leave()
    }
}

