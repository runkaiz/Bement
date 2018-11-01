//
//  AppDelegate.swift
//  Bement
//
//  Created by Runkai Zhang on 7/3/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
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
        
        /*
        tools.pushTerms(termName: TermDates.names[0], date: TermDates.fallMidTerm)
        tools.pushTerms(termName: TermDates.names[0], date: TermDates.fallTerm)
        tools.pushTerms(termName: TermDates.names[0], date: TermDates.miniTerm)
        tools.pushTerms(termName: TermDates.names[0], date: TermDates.winterMidTerm)
        tools.pushTerms(termName: TermDates.names[0], date: TermDates.winterTerm)
        tools.pushTerms(termName: TermDates.names[0], date: TermDates.springMidTerm)
        tools.pushTerms(termName: TermDates.names[0], date: TermDates.springTerm)
                */
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
