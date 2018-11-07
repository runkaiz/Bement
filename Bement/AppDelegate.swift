//
//  AppDelegate.swift
//  Bement
//
//  Created by Runkai Zhang on 7/3/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit
import WatchConnectivity
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var locationManager: CLLocationManager?
    var notificationCenter: UNUserNotificationCenter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        
        self.notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter!.delegate = self
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
        if UserDefaults().bool(forKey: "alert") == true {
            var count = 0
            for item in TermDates.terms {
                
                let date = tools.component2Date(item)
                
                if date as Date > Date() {
                    tools.pushTerms(termName: TermDates.names[count], date: item)
                    globalVariable.dateCount = count
                    break
                } else {
                    count += 1
                }
            }
        }
        
        // Your coordinates go here (lat, lon)
        let geofenceRegionCenter = CLLocationCoordinate2DMake(42.5482827, -72.6059389)
        
        /* Create a region centered on desired location,
         choose a radius for the region (in meters)
         choose a unique identifier for that region */
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter,
                                              radius: 1000,
                                              identifier: "bement")
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        let date = Date()
        
        if Calendar.current.isDateInWeekend(date) {
            
            locationManager!.startMonitoring(for: geofenceRegion)
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController) {
            if (rootViewController.responds(to: Selector(("canRotate")))) {
                // Unlock landscape view orientations for this view controller
                return .allButUpsideDown;
            }
        }
        
        // Only allow portrait (standard behaviour)
        return .portrait;
    }
    
    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        if (rootViewController == nil) { return nil }
        if (rootViewController.isKind(of: UITabBarController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        } else if (rootViewController.isKind(of: UINavigationController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
        } else if (rootViewController.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }
}

extension AppDelegate: WCSessionDelegate {
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        guard let alertRequest = message["alert"] as? String else {
            replyHandler([:])
            return
        }
        
        switch alertRequest {
        case "true":
            replyHandler(["alert":"On"])
            UserDefaults().set(true, forKey: "alert")
        case "false":
            replyHandler(["alert":"Off"])
            UserDefaults().set(false, forKey: "alert")
        case "?":
            let stats = String(UserDefaults().bool(forKey: "alert"))
            replyHandler(["alert":stats])
        default:
            replyHandler(["alert":"If you see this, something is wrong and this should never appear!"])
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        if error != nil {
            print(error!)
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session Inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Session Deactivated")
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    // called when user Exits a monitored region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            self.handleEventWhenExit(forRegion: region)
        }
    }
    
    // called when user Enters a monitored region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            self.handleEventWhenEnter(forRegion: region)
        }
    }
    
    func handleEventWhenEnter(forRegion region: CLRegion!) {
        
        // customize your notification content
        let content = UNMutableNotificationContent()
        content.title = "Welcome to the Bement School!"
        content.body = "You might want to turn your do not disturb mode one"
        content.sound = UNNotificationSound.default
        
        // when the notification will be triggered
        let timeInSeconds: TimeInterval = (60 * 15) // 60s * 15 = 15min
        // the actual trigger object
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInSeconds,
                                                        repeats: false)
        
        // notification unique identifier, for this example, same as the region to avoid duplicate notifications
        let identifier = region.identifier
        
        // the notification request object
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        
        // trying to add the notification request to notification center
        notificationCenter!.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("Error adding notification with identifier: \(identifier)")
            }
        })
    }
    
    func handleEventWhenExit(forRegion region: CLRegion!) {
        
        // customize your notification content
        let content = UNMutableNotificationContent()
        content.title = "Good bye!"
        content.body = "You have left the Bement School"
        content.sound = UNNotificationSound.default
        
        // when the notification will be triggered
        let timeInSeconds: TimeInterval = (60 * 15) // 60s * 15 = 15min
        // the actual trigger object
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInSeconds,
                                                        repeats: false)
        
        // notification unique identifier, for this example, same as the region to avoid duplicate notifications
        let identifier = region.identifier
        
        // the notification request object
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        
        // trying to add the notification request to notification center
        notificationCenter!.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("Error adding notification with identifier: \(identifier)")
            } else {
                
            }
        })
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // when app is onpen and in foregroud
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // get the notification identifier to respond accordingly
        let identifier = response.notification.request.identifier
        
        // do what you need to do
        
        // ...
    }
    
}
