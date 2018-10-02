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
    
    public static func pushTerms(termName:String, date:DateComponents) {
        
        //get the notification center
        let center =  UNUserNotificationCenter.current()
        
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = "New Term Reports!"
        content.subtitle = termName
        content.body = "This term's report is here!"
        content.sound = .default
        
        //notification trigger can be based on time, calendar or location
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        //create request to display
        let request = UNNotificationRequest(identifier: "termPush", content: content, trigger: trigger)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
    public static func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hr
        components.minute = min
        components.second = sec
        let date = calendar.date(from: components as DateComponents)
        return date! as NSDate
    }
    
    public static func component2Date(_ component: DateComponents) -> NSDate {
        let calender = NSCalendar(calendarIdentifier: .gregorian)
        let date = calender?.date(from: component)
        return date! as NSDate
    }
}
