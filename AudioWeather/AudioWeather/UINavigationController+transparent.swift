//
//  UINavigationController+transparent.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/27/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit

extension UINavigationController {
    // TODO: Is there an implicit method to make this happen?
    // Perhaps need to define a class and use this class in the storyboard and override viewDidLoad().
    func makeTransparent() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage     = UIImage()
        navigationBar.isTranslucent   = true
    }
}
