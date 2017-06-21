//
//  UIView+rotate360Degrees.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/21/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit

extension UIView {
    /// Continuously rotate the view by 360 degrees.
    ///
    /// - Parameter duration: Duration of rotation in seconds.
    func rotate360Degrees(duration: CFTimeInterval = 1.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
