//
//  DetailViewController.swift
//  Notare
//
//  Created by Bree Jeune on 3/2/20.
//  Copyright © 2020 Young. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailTextView: UITextView!
    
    var text: String = ""
    
    var masterView: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTextView.text = text
        self.navigationItem.largeTitleDisplayMode = .never

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailTextView.becomeFirstResponder() // function to bring up software keyboard by automatically selecting text view
    }
    
    func setText(t: String) {
        text = t
        
        // verifying to see if the view is loaded before we perform any modifications
        
        if isViewLoaded {
            // modify text view after view has loaded
            detailTextView.text = t
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newRowText = detailTextView.text
        detailTextView.resignFirstResponder()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
