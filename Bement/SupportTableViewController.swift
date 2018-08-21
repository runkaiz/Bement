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
        
        let actionSheet = UIAlertController(title: NSLocalizedString("CS", comment: ""), message: NSLocalizedString("CSD", comment: ""), preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        
        let phone = UIAlertAction(title: NSLocalizedString("Phone", comment: ""), style: .destructive) { action in
            
            self.makeAPhoneCall()
        }
        
        let icloud = UIAlertAction(title: NSLocalizedString("QuickSubmit", comment: ""), style: .default ) { action in
            
            CKContainer.default().accountStatus(completionHandler: { accountStatus, error in
                if accountStatus == .noAccount {
                    
                    let noiCloudAlert = UIAlertController(title: NSLocalizedString("SignICloud", comment: ""), message: NSLocalizedString("iCloudMessage", comment: ""), preferredStyle: .alert)
                    
                    let button = UIAlertAction(title: NSLocalizedString("toSettings", comment: ""), style: .default, handler: { action in
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
        actionSheet.addAction(phone)
        actionSheet.addAction(cancel)
        phone.isEnabled = true
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func makeAPhoneCall()  {
        let url: NSURL = URL(string: "TEL://4137735967")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}
