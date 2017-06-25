//
//  UnitsModel.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/25/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import Foundation
import SwiftyJSON

class UnitsModel {
    static var distanceUnit = "ft"
    static var pressureUnit = "in"
    static var speedUnit = "mph"
    static var temperatureUnit = "F"

    init(json: JSON) {
        if let distance = json[UnitFields.distance.rawValue].string {
            UnitsModel.distanceUnit = distance
        }
        if let pressure = json[UnitFields.pressure.rawValue].string {
            UnitsModel.pressureUnit = pressure
        }
        if let speed = json[UnitFields.speed.rawValue].string {
            UnitsModel.speedUnit = speed
        }
        if let temperature = json[UnitFields.temperature.rawValue].string {
            UnitsModel.temperatureUnit = temperature
        }
    }
}
