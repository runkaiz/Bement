//
//  ComposeViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit
import MessageUI
import Foundation

class ComposeViewController: UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet var composeMain: UITextView!
    
    @IBOutlet var textPlaceholder: UILabel!
    
    @IBOutlet var send: UIButton!
    
    @IBOutlet var emailField: UITextField!
    
    @IBOutlet var categorySeletion: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        composeMain.delegate = self
        
        textViewDidChange(composeMain)
        tools.beautifulButton(send)
    }
    
    @IBAction func Send(_ sender: Any) {
        
        let mailComposeViewController = configureMailController()
        
        if MFMailComposeViewController.canSendMail() {
            
            if composeMain != nil {
                self.present(mailComposeViewController, animated: true, completion: nil)
            }
            
            else {
                
                let alert = UIAlertController(title: "I can't see!", message: "There is nothing in the boxs!", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(dismiss)
                present(alert, animated: true, completion: nil)
            }
        } else {
            showMailError()
        }
    }
    
    func showMailError() {
        
        let sendEmailErrorAlert = UIAlertController(title: "Could not send email", message: "Something went wrong, check your wireless connection?", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendEmailErrorAlert.addAction(dismiss)
        self.present(sendEmailErrorAlert, animated: true, completion: nil)
    }
    
    func configureMailController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["support@numericdesign.org"])
        mailComposerVC.setSubject("From Bement Parent Portal Support System")
        
        let category = ["Comments","Error","Suggestion","Help"]
        
        mailComposerVC.setMessageBody("This is a message from \(emailField.text!)----------------------------------------\(composeMain.text!)----------------------------------------Category: \(category[categorySeletion.selectedSegmentIndex])", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let alpha = CGFloat(textView.text.isEmpty ? 1.0 : 0.0)
        if alpha != textPlaceholder.alpha {
            UIView.animate(withDuration: 0.3) { self.textPlaceholder.alpha = alpha } }
    }

}
