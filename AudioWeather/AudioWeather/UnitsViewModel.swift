//
//  UnitsViewModel.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/25/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit

class UnitsViewModel {
    static func formattedTemperature(_ text: String) -> String {
        return String(format: "%@°%@", text, UnitsModel.temperatureUnit)
    }
    static func formattedDirection(_ text: String) -> String {
        return String(format: "%@°", text)
    }
    static func formattedSpeed(_ text: String) -> String {
        return String(format: "%@ %@", text, UnitsModel.speedUnit)
    }
}
