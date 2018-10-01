//
//  UIViewExtensions.swift
//  Bement
//
//  Created by Runkai Zhang on 9/30/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fadeIn() {
        // Move our fade out code from earlier
        self.isHidden = false
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }) { bool in
            self.isHidden = true
        }
    }
}
