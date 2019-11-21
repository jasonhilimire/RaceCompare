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

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddEventMode = presentingViewController is UINavigationController
        
        if isPresentingInAddEventMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The DetailViewController is not inside a navigation controller.")
        }
    }
    
    
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

        // Handle the text fields user input through delegate call backs
        eventNameField.delegate = self
        
        loadEventData()
        updateSaveButtonStatus()

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
    
    func loadEventData() {
        if let event = event {
            navigationItem.title = event.name
            eventNameField.text = event.name
            stageField.text = event.stage
            percentageLabel.text = "\(String(describing: event.percentDiff))"
            compareTimeField.text = "\(String(describing: event.compareTime))"
            timeField.text = "\(String(describing: event.userTime))"
            notesField.text = event.note

        }
    }
    
    func percentCompare() -> Float {
        let userTime = Float(timeField.text!)
        let compareTime = Float(compareTimeField.text!)
        
        if userTime != nil  && compareTime != nil{
            let percent = Float((compareTime! * 100) / userTime!)
            
            percentageLabel.text = String(format: "%.2f", percent) + "%"
            return percent
        } else {
            
            percentageLabel.text = "0.00%"
            return 0.00
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Configure Destination view Controller when Save is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }

        let name = eventNameField.text ?? ""
        let compareTime = Int(compareTimeField.text ?? "")
        let userTime = Int(timeField.text ?? "")
        let percentDiff = percentCompare()
        let stage = stageField.text ?? ""
        let note = notesField.text ?? ""
        
        
        // set the event to be passed to the ViewController
        event = Event(name: name, enteredStage: stage, percentDiff: percentDiff , userTime: userTime ?? 0, compareTime: compareTime ?? 0, enteredNote: note)
        
        print("PercentDiff = \(percentDiff)")
    }
    
    //MARK: - Private Methods
    
    private func updateSaveButtonStatus() {
        //Disable the save button
        let text = eventNameField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
}
