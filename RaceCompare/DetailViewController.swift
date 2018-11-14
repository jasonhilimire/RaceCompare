//
//  DetailViewController.swift
//  RaceCompare
//
//  Created by Jason Hilimire on 11/12/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet var eventNameField: UITextField!
    
    @IBOutlet var dateField: UITextField!
    
    @IBOutlet var compareTimeField: UITextField!
    @IBOutlet var timeField: UITextField!
    
    @IBOutlet var notesField: UITextField!
    
    @IBOutlet var percentageLabel: UILabel!
    
    //MARK: - View
    
    var event = Event(name: "", date: nil, userTime: nil, compareTime: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameField.text = event.name

        // unwrap the text fields and Cast as Doubles
        if let time = Double(timeField.text!) {
            event.userTime = time
        }
        
        if let compTime = Double(compareTimeField.text!) {
            event.compareTime = compTime
        }

        
        
        
        
    }
    
}
