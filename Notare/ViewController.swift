//
//  ViewController.swift
//  Notare
//
//  Created by Bree Young on 3/2/20.
//  Copyright © 2020 Young. All rights reserved.
//

import UIKit




// adding a protocol to get class to conform to UITableViewDataSource and UITableViewDelegate
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, UISearchDisplayDelegate {
    
    
    let notesController = NoteController()
    
    // making table view a property inside view controller
    @IBOutlet weak var tableView: UITableView!
    
    // creating a new instance of the variable "data" in order to get a data source for table view
    
    
    var selectedRow: Int = -1
    var newRowText: String = ""
    
    
    let tableData: [String] = []
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    
    // runs when all user interface elements are loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting the tableview as the data source
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Notare"
        self.navigationItem.largeTitleDisplayMode = .always
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()

            tableView.tableHeaderView = controller.searchBar

            return controller
        })()

        // Reload the table
        tableView.reloadData()
        
    }
   
    
    // IBAction to call editNote method
    @IBAction func editNote(_ sender: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    
    //numberOfRowsInSection method - how many rows are going to be in the table view?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return notesController.notes.count // setting number of rows based on the count of elements in the array "data"
            
        }
        
        
        
        
    }

    
    //CellForRowAt method - creating cell, applying data from array and returning a UITableView cell based on the index path of the array "data"
    
    // add guard let / if let to check and make sure cell is not nil before running code
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteTableViewCell else {return UITableViewCell() }
//        //setting the text for the cell based on the text label property
//        //        IndexPath contains the row and the section of the table view whose cell we are creating
//
//        let note = notesController.notes[indexPath.row]
//        cell.notes = note
//        return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        if (resultSearchController.isActive) {
            cell.textLabel?.text = filteredTableData[indexPath.row]

            return cell
        }
        else {
            cell.textLabel?.text = tableData[indexPath.row]
            print(tableData[indexPath.row])
            return cell
        }
    }
    
    // when edit button is selected, puts table into editing mode - allows for deletion
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    
    // deletes rows when in edit mode and updates the "data" array after deletion
    // also adds animation effect when deleting
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
            let note = notesController.notes[indexPath.row]
               
               notesController.deleteFromPersistentStore(noteItem: note)
               
               tableView.deleteRows(at: [indexPath], with: .automatic)
           }
       }
    
    // uses the delagate to find which row was selected
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailNotes", sender: nil)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)

        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]

        self.tableView.reloadData()
    }
    
    
}
