//
//  GlobalVariable.swift
//  Bement
//
//  Created by Runkai Zhang on 8/19/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import Foundation
import CloudKit

struct globalVariable {
    public static var messageRecordsName: [CKRecord] = []
    public static var messageCategory = [Int : [CKRecord]]()
    public static var row = Int()
    public static var section = Int()
    public static var errorRecordsName: [CKRecord] = []
    public static var firstTimeIndicator = false
    public static var username = String()
    public static var password = String()
}
