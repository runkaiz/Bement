//
//  MessagesTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/10/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {

    let sectionName = [NSLocalizedString("help", comment: ""), NSLocalizedString("error", comment: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalVariable.messageCategory[section]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessagesTableViewCell
        
        cell.title.text = globalVariable.messageCategory[indexPath.section]![indexPath.row]["email"]
        cell.date.text = globalVariable.messageCategory[indexPath.section]![indexPath.row]["time"]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        globalVariable.row = indexPath.row
        globalVariable.section = indexPath.section
        
        self.performSegue(withIdentifier: "info", sender: self)
    }
}
