//
//  AdminViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/8/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit
import CloudKit

class AdminViewController: UIViewController {

    @IBOutlet var messageButton: UIButton!
    
    @IBOutlet var errorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tools.beautifulButton(messageButton)
        tools.beautifulButton(errorButton)
    }
    
    @IBAction func message(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: NSLocalizedString("wait", comment: ""), preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        showMessages()
    }
    
    @IBAction func errorButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: NSLocalizedString("wait", comment: ""), preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        showErrors()
    }
    
    func showErrors() {
        
        DispatchQueue.main.async {
            let container = CKContainer.default()
            let database = container.publicCloudDatabase
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "Error", predicate: predicate)
            let operation = CKQueryOperation(query: query)
            
            var errorRecords: [CKRecord] = []
            globalVariable.errorRecordsName = []
            
            operation.recordFetchedBlock = { record in
                
                errorRecords.append(record)
            }
            
            operation.queryCompletionBlock = { cursor, error in
                
                globalVariable.errorRecordsName = errorRecords
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.performSegue(withIdentifier: "error", sender: self)
                    }
                }
            }
            
            database.add(operation)
        }
    }
    
    
    func showMessages() {
        
        DispatchQueue.main.async {
            let container = CKContainer.default()
            let database = container.publicCloudDatabase
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "Message", predicate: predicate)
            let operation = CKQueryOperation(query: query)
            
            var messageRecords: [CKRecord] = []
            globalVariable.messageRecordsName = []
            
            operation.recordFetchedBlock = { record in
                
                messageRecords.append(record)
            }
            
            operation.queryCompletionBlock = { cursor, error in
                
                globalVariable.messageRecordsName = messageRecords
                
                DispatchQueue.main.async {
                    
                    if messageRecords != [] {
                        self.dismiss(animated: true, completion: nil)
                        globalVariable.messageRecordsName = messageRecords
                        self.catagorize(messageRecords)
                    } else {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: NSLocalizedString("nilTitle", comment: ""), message: NSLocalizedString("nilDetail", comment: ""), preferredStyle: .alert)
                            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.dismiss(animated: true, completion: {
                                self.present(alert, animated: true, completion: nil)
                            })
                        }
                    }
                }
            }
            
            database.add(operation)
        }
    }
    
    func catagorize(_ record: [CKRecord]) {
        
        var Errors = [CKRecord]()
        var Help = [CKRecord]()
        
        for item in record {
            
            if item["category"] == 1 {
                Errors.append(item)
            }
            
            if item["category"] == 0 {
                Help.append(item)
            }
        }
        
        globalVariable.messageCategory[0] = Errors
        globalVariable.messageCategory[1] = Help
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "messages", sender: self)
        }
    }
}
