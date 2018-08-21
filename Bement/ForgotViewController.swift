//
//  ForgotViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/8/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class ForgotViewController: UIViewController {

    @IBOutlet var contactSchool: UIButton!
    
    @IBOutlet var warning: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tools.beautifulButton(contactSchool)
        contactSchool.isEnabled = false
        warning.text = NSLocalizedString("forgotPasswordWarning", comment: "")
    }

    @IBAction func contactSchool(_ sender: Any) {
        
        makeAPhoneCall()
    }
    
    func makeAPhoneCall()  {
        let url: NSURL = URL(string: "TEL://4137747061")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}
