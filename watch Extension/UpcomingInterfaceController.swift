//
//  UpcomingInterfaceController.swift
//  watch Extension
//
//  Created by Runkai Zhang on 9/16/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import WatchKit
import Foundation


class UpcomingInterfaceController: WKInterfaceController {

    @IBOutlet var lastUpdated: WKInterfaceDate!
    
    @IBOutlet var notifyMe: WKInterfaceSwitch!

    @IBOutlet var termCell: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        termCell.setNumberOfRows(1, withRowType: "termName")
        
        let cell = termCell.rowController(at: 0) as! NextDateTableCell
        
        cell.setTerm(text: "None")
        
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
        
        
    }
}
