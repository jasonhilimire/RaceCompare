//
//  ViewController.swift
//  RaceCompare
//
//  Created by Jason Hilimire on 11/12/18.
//  Copyright © 2018 Peanut Apps. All rights reserved.
//

import UIKit




class ViewController: UITableViewController {

    var events = [Event]()
    
    // MARK: - Actions

    @IBAction func addNewEvent(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("TableView Array: \(events.count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View Appeared: TableView Array: \(events.count)")
        tableView.reloadData()
    }
    
    //MARK: - Tableview

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventCell else {
            fatalError("The dequed cell is not an instance of ShotCycleTableViewCell.")
        }
        
        let event = events[indexPath.row]
        cell.eventNameLabel.text = "\(event.name)"
        // unwrap optional stage and give default of "" if nil
        cell.stageLabel.text! = "\(event.stage ?? "")"
//        //cell.percentLabel.text = "\(event.percentcompare)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
//        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailVCSegue" {
            if let destinationVC = segue.destination as? DetailViewController {
                if let anEvent = sender as? Event {
                    destinationVC.eventNameField.text = anEvent.name
//                    destinationVC.newEvent = anEvent
                }
            }
        }
    }
}

