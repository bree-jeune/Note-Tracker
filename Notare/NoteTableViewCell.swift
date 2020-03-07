//
//  NoteTableViewCell.swift
//  Notare
//
//  Created by Bree Jeune on 3/5/20.
//  Copyright © 2020 Young. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
   
    var note: Note? {
        didSet {
            updateViews()
        }
    }
    
    
    
    
    private func updateViews() {
        guard let note = note else { return }
        textLabel?.text = note.name
        if let date = note.date {
            detailTextLabel?.text = dateFormatter.string(from: date)
        } else {
            detailTextLabel?.text = ""
        }
      
    }
}

