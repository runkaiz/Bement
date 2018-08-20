//
//  QuickSubmitViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/10/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit
import CloudKit

class QuickSubmitViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var Placeholder: UILabel!
    
    @IBOutlet var messageField: UITextView!
    
    @IBOutlet var Category: UISegmentedControl!
    
    @IBOutlet var send: UIButton!
    
    @IBOutlet var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageField.delegate = self
        textViewDidChange(messageField)
        tools.beautifulButton(send)
    }

    @IBAction func sendPressed(_ sender: Any) {
        
        var title = "Sorry"
        
        let max: UInt32 = 100
        let min: UInt32 = 0
        
        let result = arc4random_uniform(max - min) + min
        if result <= 20 {
            title = "Sorry, Mr. Belcher"
        }
        
        if messageField.text == "" {
            let alert = UIAlertController(title: "I can't see!", message: "You must write something!", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: title, style: .default, handler: nil)
            alert.addAction(dismiss)
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            if emailField.text == "" {
                let alert = UIAlertController(title: "I can't see!", message: "You must write something!", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: title, style: .default, handler: nil)
                alert.addAction(dismiss)
                
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
                    
                    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                    loadingIndicator.hidesWhenStopped = true
                    loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorView.Style.gray
                    loadingIndicator.startAnimating();
                    
                    alert.view.addSubview(loadingIndicator)
                    self.present(alert, animated: true, completion: nil)
                    self.uploadRecords()
                }
                
            }
        }
    }
    
    func uploadRecords() {
        //获取当前时间
        let now = Date()
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd/ HH:mm:ss"
        
        let messageRecord = CKRecord(recordType: "Message")
        
        messageRecord["time"] = dformatter.string(from: now) as NSString
        messageRecord["message"] = messageField.text as NSString
        messageRecord["email"] = emailField.text! as NSString
        messageRecord["category"] = Category.selectedSegmentIndex
        
        let myContainer = CKContainer.default()
        let publicDatabase = myContainer.publicCloudDatabase
        
        DispatchQueue.main.async {
            publicDatabase.save(messageRecord) {
                (record, error) in
                if let error = error {
                    
                    let string = String(describing: error)
                    
                    if string != "" {
                        self.uploadError(error)
                        
                        let alert = UIAlertController(title: "oh no...", message: "An error appeared", preferredStyle: .alert)
                        
                        let dismiss = UIAlertAction(title: "Come on", style: .cancel, handler: nil)
                        alert.addAction(dismiss)
                        
                        DispatchQueue.main.async {
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                    
                    return
                }
                
                let alert = UIAlertController(title: "Successful", message: "Successfully uploaded your messages", preferredStyle: .alert)
                
                let dismiss = UIAlertAction(title: "Hurray!", style: .cancel, handler: nil)
                
                alert.addAction(dismiss)
                
                DispatchQueue.main.async {
                    self.dismiss(animated: false, completion: nil)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func uploadError(_ error: Error) {
        let errorRecord = CKRecord(recordType: "Error")
        
        let string = String(describing: error) as NSString
        
        errorRecord["error"] = string 
        
        let myContainer = CKContainer.default()
        let publicDatabase = myContainer.publicCloudDatabase
        
        DispatchQueue.main.async {
            publicDatabase.save(errorRecord) {
                (record, error) in
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let alpha = CGFloat(textView.text.isEmpty ? 1.0 : 0.0)
        if alpha != Placeholder.alpha {
            UIView.animate(withDuration: 0.3) { self.Placeholder.alpha = alpha } }
    }
}
