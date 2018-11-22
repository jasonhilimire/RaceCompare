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
    
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DetailViewController, let event = sourceViewController.event {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // update an exisiting event
                events[selectedIndexPath.row] = event
            } else {
            
            //Add a new event
            let newIndexPath = IndexPath(row: events.count, section: 0)
            
            events.append(event)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
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
            fatalError("The dequed cell is not an instance of EventCell.")
        }
        
        let event = events[indexPath.row]
        cell.eventNameLabel.text = "\(event.name)"
        // unwrap optional stage and give default of "" if nil
//        cell.stageLabel.text! = "\(event.stage ?? "")"
//        //cell.percentLabel.text = "\(event.percentcompare)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    // delete a row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // remove the item at its indexpath
        events.remove(at: indexPath.row)

        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        // this is a deletion with the animation
        
        tableView.reloadData()
        
        
    }
    

    
    
    // MARK: - SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            //
            print("AddItem")
            
        case "detailVCsegue":
            guard let eventDetailViewController = segue.destination as? DetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedEventCell = sender as? EventCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedEvent = events[indexPath.row]
           eventDetailViewController.event = selectedEvent
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
        
        
        
        
        

    }
}

