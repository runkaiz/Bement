//
//  Functions.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class tools {
    
    public static func beautifulButton(_ object:AnyObject) {
        object.layer?.cornerRadius = 10
        object.layer?.masksToBounds = true
    }
    
    public static func push(title:String, subtitle:String, body:String, sound:UNNotificationSound, triggerInterval:TimeInterval, repeating:Bool, id:String) {
        
        //get the notification center
        let center =  UNUserNotificationCenter.current()
        
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        
        //notification trigger can be based on time, calendar or location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:triggerInterval, repeats: repeating)
        
        //create request to display
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
    public static func pushScheduled(title:String, subtitle:String, body:String, sound:UNNotificationSound, date:DateComponents, repeating:Bool, id:String) {
        
        //get the notification center
        let center =  UNUserNotificationCenter.current()
        
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        
        //notification trigger can be based on time, calendar or location
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: repeating)
        
        //create request to display
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
}
