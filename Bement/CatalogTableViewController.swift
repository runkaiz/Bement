//
//  CatalogTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 9/24/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class CatalogTableViewController: UITableViewController {
    
    var indexRow = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            indexRow = indexPath.row
            self.dismiss(animated: true) {
                self.present(ResourcesCollectionViewController(), animated: true)
            }
        case 2:
            indexRow = indexPath.row
            self.dismiss(animated: true) {
                self.present(ResourcesCollectionViewController(), animated: true)
            }
        case 3:
            indexRow = indexPath.row
            self.dismiss(animated: true) {
                self.present(ResourcesCollectionViewController(), animated: true)
            }
        case 4:
            indexRow = indexPath.row
            self.dismiss(animated: true) {
                self.present(ResourcesCollectionViewController(), animated: true)
            }
        case 5:
            indexRow = indexPath.row
            self.dismiss(animated: true) {
                self.present(ResourcesCollectionViewController(), animated: true)
            }
        case 6:
            indexRow = indexPath.row
            self.dismiss(animated: true) {
                self.present(ResourcesCollectionViewController(), animated: true)
            }
        case 7:
            indexRow = indexPath.row
            self.dismiss(animated: true) {
                self.present(ResourcesCollectionViewController(), animated: true)
            }
        case 8:
            indexRow = indexPath.row
            self.dismiss(animated: true) {
                self.present(ResourcesCollectionViewController(), animated: true)
            }
        case 9:
            indexRow = indexPath.row
            self.dismiss(animated: true) {
                self.present(ResourcesCollectionViewController(), animated: true)
            }
        default:
            print("This is going to the library!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "resource" {
            
            // Create a variable that you want to send
            let catalogID = indexRow
            
            let destinationVC = segue.destination as! ResourcesCollectionViewController
            destinationVC.segueData = catalogID
        }
    }
}
