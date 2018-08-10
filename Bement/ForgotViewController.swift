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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tools.beautifulButton(contactSchool)
        contactSchool.isEnabled = false
    }

    @IBAction func contactSchool(_ sender: Any) {
        
        makeAPhoneCall()
    }
    
    func makeAPhoneCall()  {
        let url: NSURL = URL(string: "TEL://1234567890")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}
