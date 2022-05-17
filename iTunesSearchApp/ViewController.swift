//
//  ViewController.swift
//  iTunesSearchApp
//
//  Created by Harrison Kleiman on 5/17/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func searchPressed(_ sender: Any) {
        guard let term = searchTextField.text else { return }
       
        SearchResultController.searchResultsForSearchTerm(searchTerm: term) { [weak self] (results) in
            if let searchResults = results,
               let firstResult = searchResults.first {
                DispatchQueue.main.async {
                    // This closure will be scheduled to run on main queue
                    self?.resultsLabel.text = "\(firstResult.trackName) - \(firstResult.artistName)"
                }
            }
        }
    }
}

