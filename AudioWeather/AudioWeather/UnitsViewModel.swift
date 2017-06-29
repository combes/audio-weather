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
    static func formattedSpeed(_ text: String) -> String {
        return String(format: "%@ %@", text, UnitsModel.speedUnit)
    }
    static func fullDay(_ day: String) -> String {
        var text = ""
        
        switch day {
        case "Sat":
            text = "Saturday"
        case "Sun":
            text = "Sunday"
        case "Mon":
            text = "Monday"
        case "Tue":
            text = "Tuesday"
        case "Wed":
            text = "Wednesday"
        case "Thu":
            text = "Thursday"
        case "Fri":
            text = "Friday"
        default:
            text = ""
        }
        
        return text
    }
}
