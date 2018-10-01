//
//  ClagettViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 9/26/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit
import WebKit

class ClagettViewController: UIViewController, WKUIDelegate {

    @IBOutlet var libraryView: WKWebView!
    @objc func canRotate() -> Void {}
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        libraryView = WKWebView(frame: .zero, configuration: webConfiguration)
        libraryView.uiDelegate = self
        view = libraryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string:"https://bementlibrary.follettdestiny.com/common/welcome.jsp?context=saas23_2000489")
        let myRequest = URLRequest(url: myURL!)
        libraryView.load(myRequest)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        
    }
}
