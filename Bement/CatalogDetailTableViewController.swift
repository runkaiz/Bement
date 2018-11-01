//
//  CatalogDetailTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 10/31/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class CatalogDetailTableViewController: UITableViewController {

    @IBOutlet weak var titleTextDetail: UINavigationItem!
    var segueData = Int()
    var catalogs = [String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch segueData {
        case 1:
            titleTextDetail.title = "Kindergarten"
            catalogs = catalog.Gradek3
        case 2:
            titleTextDetail.title = "Grade 1"
            catalogs = catalog.Gradek3
        case 3:
            titleTextDetail.title = "Grade 2"
            catalogs = catalog.Gradek3
        case 4:
            titleTextDetail.title = "Grade 3"
            catalogs = catalog.Gradek3
        case 5:
            titleTextDetail.title = "Grade 4"
            catalogs = catalog.Grade45
        case 6:
            titleTextDetail.title = "Grade 5"
            catalogs = catalog.Grade45
        case 7:
            titleTextDetail.title = "Grade 6"
            catalogs = catalog.Grade6
        case 8:
            titleTextDetail.title = "Grade 7"
            catalogs = catalog.Grade789
        case 9:
            titleTextDetail.title = "Grade 8 & 9"
            catalogs = catalog.Grade789
        default:
            print("This should not happen!")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CatalogTableViewCell
        
        cell.title.text = catalogs[indexPath.row]
        
        return cell
    }
}
