//
//  MessageInfoViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/20/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class MessageInfoViewController: UIViewController {

    @IBOutlet var information: UITextView!
    
    @IBOutlet var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        information.text = globalVariable.messageCategory[globalVariable.section]?[globalVariable.row]["message"]
        email.text = globalVariable.messageCategory[globalVariable.section]?[globalVariable.row]["email"]
    }
}
