//
//  ErrorsTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/20/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class ErrorsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalVariable.errorRecordsName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ErrorTableViewCell
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .short
        let date = dateformatter.string(from: globalVariable.errorRecordsName[indexPath.row].creationDate!)
        cell.title.text = date
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        globalVariable.row = indexPath.row
        self.performSegue(withIdentifier: "errorInfo", sender: self)
    }
}
