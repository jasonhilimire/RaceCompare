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
    var stage: String?
    var userTime: Int?
    var compareTime: Int?
    var percentDiff: Float?
    var note: String?
    

    
    init(name: String, stage: String?, userTime: Int?, compareTime: Int?) {
        self.name = name
        self.stage = stage
        self.userTime = userTime
        self.compareTime = compareTime
    
        super.init()
    }
    
//    convenience override init() {
//        self.init(name: "", date: nil, userTime: nil, compareTime: nil)
//    }
}
