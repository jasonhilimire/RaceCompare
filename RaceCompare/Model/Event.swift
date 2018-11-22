//
//  File.swift
//  RaceCompare
//
//  Created by Jason Hilimire on 11/12/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class Event: NSObject, NSCoding {

    
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
    
    
    // MARK:- NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // Name is required, initializer should fail if cannot decode name string
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            return nil
        }
        
//        let stage = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        
        
        self.init(name: name)
    }
    
    // MARK:- Archiving Paths
    
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendPathComponent("events")
    

}
