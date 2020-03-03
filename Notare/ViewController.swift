//
//  ViewController.swift
//  Notare
//
//  Created by Bree Young on 3/2/20.
//  Copyright © 2020 Young. All rights reserved.
//

import UIKit


// adding a protocol to get class to conform to UITableViewDataSource and UITableViewDelegate
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // making table view a property inside view controller 
    @IBOutlet weak var tableView: UITableView!
    
    // creating a new instance of the variable "data" in order to get a data source for table view
    var data: [String] = []
    
    var notes: [Note] = []
    
    var selectedRow: Int = -1
    var newRowText: String = ""
    
    
    let searchController = UISearchController(searchResultsController: nil)

    var filteredNotes: [Note] = [] // will hold the results of the user search
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    
    // to save data to a file - we have to start UserDefault saving code and modify it using File URL
    
    var fileURL: URL!
    
    // runs when all user interface elements are loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting the tableview as the data source
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Notare"
        self.navigationItem.largeTitleDisplayMode = .always
        
        
        // file URL
        let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        fileURL = baseURL.appendingPathComponent("notes.txt")
        
        loadNotes() // calls the load notes function from persistence when loading/opening up app
        
        
        
        // informs the search controller of any text changes within the UI search bar
        searchController.searchResultsUpdater = self
        // the current view will show the results and not obscure view
        searchController.obscuresBackgroundDuringPresentation = false
        // placeholder text
        searchController.searchBar.placeholder = "Search Notes"
        navigationItem.searchController = searchController
        // closes the search bar when the user navigates to another view controller
        definesPresentationContext = true

    }
    
    // ***********
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        data[selectedRow] = newRowText
        if newRowText == "" {
            data.remove(at: selectedRow)
        }
        tableView.reloadData()
        saveNotes()
    }
    
    // ***********
    
    // IBAction to call createNewNote method
    @IBAction func createNewNoteButton(_ sender: UIBarButtonItem) {
        createNewNote()
    }
    
    // IBAction to call editNote method
    @IBAction func editNote(_ sender: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    // method for creating new notes
    
    func createNewNote() {
        
        if tableView.isEditing {
            return
        }
        
        let name: String = "" // gives note a string title based on user input
        data.insert(name, at: 0) // indexes new note at the beginning of the index of "data" array
        
        let indexPath: IndexPath = IndexPath(row: 0, section: 0) // creates a new row after adding a new note to array
         tableView.insertRows(at: [indexPath], with: .automatic) // animates the creation of a new row
        
        // identifies selected row when segue is triggered / connected to prepare for segue method
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        
        self.performSegue(withIdentifier: "detailNotes", sender: nil)
        
        tableView.reloadData()
    }
    
    //numberOfRowsInSection method - how many rows are going to be in the table view?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count // setting number of rows based on the count of elements in the array "data"
    }
    
    //CellForRowAt method - creating cell, applying data from array and returning a UITableView cell based on the index path of the array "data"
    
    // add guard let / if let to check and make sure cell is not nil before running code
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row] //setting the text for the cell based on the text label property
//        IndexPath contains the row and the section of the table view whose cell we are creating
        return cell
    }
    
    // when edit button is selected, puts table into editing mode - allows for deletion
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    
    // deletes rows when in edit mode and updates the "data" array after deletion
    // also adds animation effect when deleting
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    }
    
    // uses the delagate to find which row was selected
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailNotes", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView: DetailViewController = segue.destination as! DetailViewController
        selectedRow = tableView.indexPathForSelectedRow!.row // always making sure you have a selected row before transistion to detail view controller screen
        detailView.masterView = self
        detailView.setText(t: data[selectedRow]) // sending selected cell text/data to the detail view
    }
    
    // saving the notes using persistence
    
    func saveNotes() {
        
//        creating NSArray instead of using user defaults
        let arrayDirectory = NSArray(array: data)
        do {
            try arrayDirectory.write(to: fileURL)
        } catch {
            print("Error")
        }
    }

    func loadNotes() {
        // if the value being created is not "nil" then execute the code inside of the { }
        // getting value from user defaults and typecasting it as a string array
        
        if let loadedNotes: [String] = NSArray(contentsOf: fileURL) as? [String] {
            data = loadedNotes
            tableView.reloadData()
        }
        
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    category: Note.Category? = nil) {
      filteredNotes = notes.filter { (note: Note) -> Bool in
        return note.name.lowercased().contains(searchText.lowercased())
      }

      tableView.reloadData()
    }

}

extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
  }
    
    

}

