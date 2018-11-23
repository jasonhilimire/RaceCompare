//
//  EventDataModel.swift
//  RaceCompare
//
//  Created by Jason Hilimire on 11/23/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class EventDataModel {
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let showDocumentsDirectory = paths[0]
        print(showDocumentsDirectory)  // this will show documents directory on local machine
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("RaceCompare.plist")
    }
    
    func saveEventsArray() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(events)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
            print("Event: \(events) was written")
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
                print("loadEventsArray() was run")
            } catch {
                print("Error loading Events  array!")
            }
        }
    }
    

    init () {
        loadEventsArray()
    }
}
