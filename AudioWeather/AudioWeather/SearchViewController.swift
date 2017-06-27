//
//  SearchViewController.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/20/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar to transparent
        navigationController?.makeTransparent()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(dismissView))
        
        searchField.becomeFirstResponder()
    }
    
    deinit {
        searchField.resignFirstResponder()
    }
    
    // MARK: Actions
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITextFieldDelegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let searchText = searchField.text {
            let loader = WeatherLoader()
            loader.location = searchText
            loader.refresh()
        }
        
        dismissView()

        return true
    }
}
