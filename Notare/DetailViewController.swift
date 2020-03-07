//
//  DetailViewController.swift
//  Notare
//
//  Created by Bree Jeune on 3/2/20.
//  Copyright © 2020 Young. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {
    
    var note: Note?
    var notesController: NoteController?

    
    @IBOutlet weak var detailTextView: UITextView!
    
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let noteTitle = noteTitleTextField.text else { return }
        notesController?.createNote(named: noteTitle)
        navigationController?.popViewController(animated: true)
    }
    
    var text: String = ""
    
    var masterView: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTextView.layer.shadowColor = UIColor.black.cgColor
        detailTextView.layer.shadowPath = UIBezierPath(rect: detailTextView.bounds).cgPath
        detailTextView.layer.shadowRadius = 5
        detailTextView.layer.shadowOffset = .zero
        detailTextView.layer.shadowOpacity = 0.5

        detailTextView.text = text
        self.navigationItem.largeTitleDisplayMode = .never
        detailTextView.isUserInteractionEnabled = true
        detailTextView.becomeFirstResponder() // function to bring up software keyboard by automatically selecting text view
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setText(t: String) {
        text = t
        
        // verifying to see if the view is loaded before we perform any modifications
        
        if isViewLoaded {
            // modify text view after view has loaded
            detailTextView.text = t
            detailTextView.isUserInteractionEnabled = true
            detailTextView.becomeFirstResponder() // function to bring up software keyboard by automatically selecting text view
        }
        
    }
    
 
}
