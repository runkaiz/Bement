//
//  NextDateTableCell.swift
//  watch Extension
//
//  Created by Runkai Zhang on 9/16/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import WatchKit

class NextDateTableCell: NSObject {

    @IBOutlet var termName: WKInterfaceLabel!
    
    func setTerm(text: String) {
        termName.setText(text)
    }
}
