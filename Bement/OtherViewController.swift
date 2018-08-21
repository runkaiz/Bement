//
//  OtherViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/21/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {

    @IBOutlet var soon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        soon.text = NSLocalizedString("coming-soon", comment: "")
    }
}
