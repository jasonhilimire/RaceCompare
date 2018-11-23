//
//  File.swift
//  RaceCompare
//
//  Created by Jason Hilimire on 11/12/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class Event: Codable {

    
    var name: String
//    var stage: String?
    var userTime: Int
    var compareTime: Int
    var percentDiff: Float
//    var note: String?
    

    
    init?(name: String, percentDiff: Float, userTime: Int, compareTime: Int) {
        
        // name cannot be empty
        guard !name.isEmpty else {
            return nil
        }
        
        self.name = name
//        self.stage = stage
        self.userTime = userTime
        self.compareTime = compareTime
        self.percentDiff = percentDiff

    }
    
    
    func percentCompare() -> Float {
        print ("UserTime:\(String(describing: userTime)) , CompareTime \(String(describing: compareTime))")
        
        if userTime != 0  && compareTime != 0{
            let percent = Float((compareTime * 100) / userTime)
            
            //TODO: showing as multiple decimal places- need to return it as 2
            return percent
        } else {

            return 0.00
        }
    }
    
}
