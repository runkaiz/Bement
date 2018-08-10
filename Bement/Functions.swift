//
//  Functions.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import Foundation
import UIKit

class tools {
    
    public static func beautifulButton(_ object:AnyObject) {
        object.layer?.cornerRadius = 8
        object.layer?.masksToBounds = true
    }
}
