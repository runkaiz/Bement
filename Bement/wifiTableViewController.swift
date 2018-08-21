//
//  wifiTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/21/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class wifiTableViewController: UITableViewController {

    @IBOutlet var first: UITextView!
    
    @IBOutlet var second: UITextView!
    
    @IBOutlet var third: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        first.text = NSLocalizedString("wifi-first", comment: "")
        second.text = NSLocalizedString("wifi-second", comment: "")
        third.text = NSLocalizedString("wifi-third", comment: "")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
