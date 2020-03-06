//
//  NoteTableViewCell.swift
//  Notare
//
//  Created by Bree Jeune on 3/5/20.
//  Copyright © 2020 Young. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
   
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    var notes: Note? {
        didSet {
            updateViews()
        }
    }
    
    
    func updateViews() {
        nameLabel.text = notes?.name
        categoryLabel.text = (notes?.category.rawValue)
    }
    

}

