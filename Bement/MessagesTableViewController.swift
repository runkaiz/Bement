//
//  MessagesTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/10/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit
import CloudKit

class MessagesTableViewController: UITableViewController {

    var sectionName = [NSLocalizedString("help", comment: ""), NSLocalizedString("error", comment: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if globalVariable.messageCategory[0] == nil {
            sectionName.remove(at: 0)
        } else if globalVariable.messageCategory[1] == nil {
            sectionName.remove(at: 1)
        }
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let database = CKContainer.default().publicCloudDatabase
            database.delete(withRecordID: globalVariable.messageCategory[indexPath.section]![indexPath.row].recordID) { recordID, error in
                if error != nil {
                    print(error!)
                } else {
                    DispatchQueue.main.async {
                        
                        globalVariable.messageCategory[indexPath.section]?.remove(at: indexPath.row)
                        tableView.beginUpdates()
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                        if tableView.numberOfRows(inSection: indexPath.section) == 0 {
                            tableView.deleteSections(NSIndexSet(index: indexPath.section) as IndexSet, with: .fade)
                        }
                        tableView.endUpdates()
                    }
                }
            }
        }
    }
}
