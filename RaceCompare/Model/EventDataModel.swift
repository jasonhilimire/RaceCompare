//
//  EventDataModel.swift
//  RaceCompare
//
//  Created by Jason Hilimire on 11/23/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class EventDataModel {
    
    // set up the documents directory
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let showDocumentsDirectory = paths[0]
//        print(showDocumentsDirectory)  // this will show documents directory on local machine
        return paths[0]
    }
    
    // get the documents directory and append the file named RaceCompare.plist
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("RaceCompare.plist")
    }
    
    func saveEventsArray() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(events)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print(" Error encoding Event array")
        }
    }
    
    func loadEventsArray() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                events = try decoder.decode([Event].self, from: data)
            } catch {
                print("Error loading Events  array!")
            }
        }
    }
    

    init () {
        loadEventsArray()
    }
}
