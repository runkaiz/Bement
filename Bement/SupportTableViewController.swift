//
//  SupportTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit
import CloudKit

class SupportTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            
            showActionSheets()
        }
    }
    
    func showActionSheets() {
        
        let actionSheet = UIAlertController(title: "Contact Support", message: "Please select an option from below to contact for supports, supports are not always available instantly.", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let email = UIAlertAction(title: "Email", style: .default) { action in
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "compose", sender: self)
            }
        }
        
        let phone = UIAlertAction(title: "Phone", style: .destructive) { action in
            
            self.makeAPhoneCall()
        }
        
        let icloud = UIAlertAction(title: "Quick Submit(Recommanded)", style: .default ) { action in
            
            CKContainer.default().accountStatus(completionHandler: { accountStatus, error in
                if accountStatus == .noAccount {
                    
                    let noiCloudAlert = UIAlertController(title: "Sign in to iCloud", message: "Sign in to your iCloud account to write records. On the Home screen, launch Settings, tap iCloud, and enter your Apple ID. Turn iCloud Drive on. If you don't have an iCloud account, tap Create a new Apple ID.", preferredStyle: .alert)
                    
                    let button = UIAlertAction(title: "Take me to Settings", style: .default, handler: { action in
                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                    })
                    
                    noiCloudAlert.addAction(button)
                    
                    DispatchQueue.main.async {
                        self.present(noiCloudAlert, animated: true, completion: nil)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "quicksubmit", sender: self)
                    }
                }
            })
        }
        
        actionSheet.addAction(icloud)
        actionSheet.addAction(email)
        actionSheet.addAction(phone)
        actionSheet.addAction(cancel)
        phone.isEnabled = false
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func makeAPhoneCall()  {
        let url: NSURL = URL(string: "TEL://4137735967")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}
