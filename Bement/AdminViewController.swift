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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tools.beautifulButton(messageButton)
    }
    
    @IBAction func message(_ sender: Any) {
    }
}
