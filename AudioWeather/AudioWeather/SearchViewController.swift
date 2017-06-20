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
        
        searchField.becomeFirstResponder()
    }
    
    deinit {
        searchField.resignFirstResponder()
    }
    
    // MARK: UITextFieldDelegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let searchText = searchField.text {
            let loader = WeatherLoader()
            loader.location = searchText
            loader.refresh()
        }
        
        dismiss(animated: true, completion: nil)

        return true
    }
}
