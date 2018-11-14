//
//  File.swift
//  RaceCompare
//
//  Created by Jason Hilimire on 11/12/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class Event: NSObject {
    var name: String
    var date: Date?
    var userTime: Int?
    var compareTime: Int?
    

    
    init(name: String, date: Date?, userTime: Int?, compareTime: Int?) {
        self.name = name
        self.date = date
        self.userTime = userTime
        self.compareTime = compareTime
    
        super.init()
    }
    
//    convenience override init() {
//        self.init(name: "", date: nil, userTime: nil, compareTime: nil)
//    }
}
