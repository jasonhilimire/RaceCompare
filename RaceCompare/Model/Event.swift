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
//    var userTime: Int?
//    var compareTime: Int?
//    var percentDiff: Float?
//    var note: String?
    

    
    init?(name: String) {
        
        // name cannot be empty
        guard !name.isEmpty else {
            return nil
        }
        
        self.name = name
//        self.stage = stage
//        self.userTime = userTime
//        self.compareTime = compareTime

    }
    
    
    
    // MARK:- Types
    
    // Add PropertyKey
    
    struct PropertyKey {
        static let name = "name"
        // add the other items that need to saved
    }
    
    

    

}
