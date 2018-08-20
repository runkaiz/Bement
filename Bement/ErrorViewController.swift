//
//  ErrorViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/20/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet var information: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        information.text = globalVariable.errorRecordsName[globalVariable.row]["error"]
    }
}
