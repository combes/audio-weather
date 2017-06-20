//
//  ForecastViewController.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/20/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if ((gestureRecognizer as? UISwipeGestureRecognizer) != nil) {
            // TODO: Why is this conditional succeeding for "tap" gestures?
            self.navigationController?.popViewController(animated: true)
        }
        return true
    }
}
