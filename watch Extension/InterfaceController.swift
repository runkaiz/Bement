//
//  InterfaceController.swift
//  watch Extension
//
//  Created by Runkai Zhang on 9/14/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    @IBOutlet weak var dateLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        var count = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for item in database.terms {
            
            let date = UpcomingInterfaceController.component2Date(item)
            
            if date as Date > Date() {
                let myStringafd = formatter.string(from: date as Date)
                dateLabel.setText(String(myStringafd))
                break
            } else {
                count += 1
            }
        }
        
        table.setNumberOfRows(1, withRowType: "main")
        getData()
    }
    
    func getData() {
        
        if WCSession.isSupported() == true {
            
            let session = WCSession.default
            
            session.sendMessage(["alert":"?"], replyHandler: { response in
                print("Reply from phone: \(response)")
                let data = response as! [String:String]
                database.alert = Bool(data["alert"]!)!
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

}
