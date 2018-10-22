//
//  Data.swift
//  watch Extension
//
//  Created by Runkai Zhang on 9/16/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import Foundation

struct database {
    
    public static var alert = Bool()
    public static var dates = Int()
    public static let fallMidTerm = DateComponents(year: 2018, month: 10, day: 5, hour: 10)
    public static let fallTerm = DateComponents(year: 2018, month: 11, day: 21, hour: 10)
    public static let miniTerm = DateComponents(year: 2018, month: 12, day: 20, hour: 10)
    public static let winterMidTerm = DateComponents(year: 2019, month: 2, day: 7, hour: 10)
    public static let winterTerm = DateComponents(year: 2019, month: 3, day: 14, hour: 10)
    public static let springMidTerm = DateComponents(year: 2019, month: 5, day: 2, hour: 10)
    public static let springTerm = DateComponents(year: 2019, month: 6, day: 14, hour: 10)
    
    public static let terms = [fallMidTerm, fallTerm, miniTerm, winterMidTerm, winterTerm, springMidTerm, springTerm]
    public static let names = ["Fall Mid Term", "Fall Term", "Mini Term", "Winter Mid Term", "Winter Term", "Spring Mid Term", "Final Term"]
}
