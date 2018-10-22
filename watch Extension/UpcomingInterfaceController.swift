//
//  UpcomingInterfaceController.swift
//  watch Extension
//
//  Created by Runkai Zhang on 9/16/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class UpcomingInterfaceController: WKInterfaceController {
    
    @IBOutlet var notifyMe: WKInterfaceSwitch!

    @IBOutlet var termCell: WKInterfaceTable!
    
    @IBOutlet var dateLeft: WKInterfaceLabel!
    
    var alert = Bool()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if database.alert == true {
            self.notifyMe.setOn(true)
        } else {
            self.notifyMe.setOn(false)
        }
        
        termCell.setNumberOfRows(1, withRowType: "termName")
        
        let cell = termCell.rowController(at: 0) as! NextDateTableCell
        
        getAlertStats()
        
        var count = 0
        let calendar = NSCalendar.current
        for item in database.terms {
            
            let date = component2Date(item)
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: date as Date)
            
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            if date as Date > Date() {
                dateLeft.setText("\(String(describing: components.day!))")
                cell.setTerm(text: database.names[count])
                break
            } else {
                count += 1
            }
        }
    }
    
    func component2Date(_ component: DateComponents) -> NSDate {
        let calender = NSCalendar(calendarIdentifier: .gregorian)
        let date = calender?.date(from: component)
        return date! as NSDate
    }
    
    func getAlertStats() {
        if WCSession.isSupported() == true {
            
            let session = WCSession.default
            
            session.sendMessage(["alert":"?"], replyHandler: { response in
                print("Reply from phone: \(response)")
                let data = response as! [String:String]
                database.alert = Bool(data["alert"]!)!
                if database.alert == true {
                    self.notifyMe.setOn(true)
                } else {
                    self.notifyMe.setOn(false)
                }
            }, errorHandler: { error in
                print(error)
                } as (Error) -> Void)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func notifySettings(_ value: Bool) {
        
        alert = value
        
        if alert == true {
            
            reloadData(["alert":"true"])
        } else {
            
            reloadData(["alert":"false"])
        }
    }
    
    func reloadData(_ data: [String : Any]) {
        
        if WCSession.isSupported() == true {
            
            let session = WCSession.default
            
            session.sendMessage(data, replyHandler: { response in
                print("Reply from phone: \(response)")
            }, errorHandler: { error in
                print(error)
                } as (Error) -> Void)
        }
    }
}
