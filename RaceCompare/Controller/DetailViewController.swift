//
//  DetailViewController.swift
//  RaceCompare
//
//  Created by Jason Hilimire on 11/12/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    // MARK: - @IBOutlets
    @IBOutlet var eventNameField: UITextField!
    @IBOutlet var stageField: UITextField!
    @IBOutlet var compareTimeField: UITextField!
    @IBOutlet var timeField: UITextField!
    @IBOutlet var notesField: UITextField!
    @IBOutlet var percentageLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
//    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
//
//        let newEvent = Event(name: "", stage: "", userTime: nil, compareTime: nil)
//        // unwrap the text fields and Cast as Doubles
//        if let time = Int(timeField.text!) {
//            newEvent.userTime = time
//        }
//
//        if let compTime = Int(compareTimeField.text!) {
//            newEvent.compareTime = compTime
//        }
//
//
//        if let name = eventNameField.text {
//            newEvent.name = name
//        }
//        print("Name:\(newEvent.name)")
//
//        events.append(newEvent)
//        print("New Item: \(newEvent.name). Array count: \(events.count)")
//
//    }

  
    
    
    //MARK: - Variables
    
    var timePickerView = UIPickerView()
    var hour = 0
    var minutes = 0
    var seconds = 0
    var event: Event?
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set PickerView Delegate and datasource
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        compareTimeField.inputView = timePickerView
        timeField.inputView = timePickerView

        eventNameField.delegate = self
        
        updateSaveButtonStatus()
        loadEventData()


    }
    

    
    // MARK: - PickerView Setup
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1,2:
            return 60
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) hours"
        case 1:
            return "\(row) min"
        case 2:
            return "\(row) sec"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break;
        }
        

        let totalTimeInSeconds = ((((hour * 60) + minutes) * 60) + seconds)
        
        if compareTimeField.isEditing {
            self.compareTimeField.text = "\(totalTimeInSeconds)"
        } else if timeField.isEditing {
            self.timeField.text = "\(totalTimeInSeconds)"
        }
        percentCompare()
    }
    
    // MARK: - UITextFieldDelegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonStatus()
        navigationItem.title = eventNameField.text
    }
    
    
    //MARK: - Functions
    func percentCompare() {
        let userTime = Float(timeField.text!)
        let compareTime = Float(compareTimeField.text!)
        
        print ("UserTime:\(String(describing: userTime)) , CompareTime \(String(describing: compareTime))")
 
        if userTime != nil  && compareTime != nil{
            let percent = Float((userTime! * 100) / compareTime!)
            
            percentageLabel.text = "\(percent)%"
            //TODO: NOT SHOWING PERCENTAGE AS DECIMAL?  CHANGE TO FLOAT??
        } else {
            
            percentageLabel.text = "0.00%"
        }

    }
    
    func loadEventData() {
//        eventNameField.text = event.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Configure Destination view Controller when Save is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        let name = eventNameField.text ?? ""
        
        
        // set the event to be passed to the ViewController
        event = Event(name: name)
    }
    
    //MARK: - Private Methods
    
    private func updateSaveButtonStatus() {
        //Disable the save button
        let text = eventNameField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
}
