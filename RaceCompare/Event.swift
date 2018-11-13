//
//  File.swift
//  RaceCompare
//
//  Created by Jason Hilimire on 11/12/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class Event {
    var name: String
    var date: Date?
    var userTime: Double?
    var compareTime: Double?
    

    
    init(name: String, date: Date?, userTime: Double?, compareTime: Double?) {
        self.name = name
        self.date = date
        self.userTime = userTime
        self.compareTime = compareTime
    
    }
}
