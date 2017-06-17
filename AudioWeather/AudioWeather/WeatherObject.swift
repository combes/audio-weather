//
//  WeatherObject.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/17/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import SwiftyJSON

class WeatherObject: CustomDebugStringConvertible {
    
    // Units
    var distanceUnit: String!
    var pressureUnit: String!
    var speedUnit: String!
    var temperatureUnit: String!
    
    var debugDescription: String {
        var description = ""
        if let distanceValue = distanceUnit, let pressureValue = pressureUnit, let speedValue = speedUnit, let temperatureValue = temperatureUnit {
            description += "Units(distance: \(distanceValue), pressure: \(pressureValue), speed: \(speedValue), temperature: \(temperatureValue))"
        }
        return description
    }

    required init(json: JSON) {
        // Parse units
        var units = json[WeatherFields.query.rawValue][WeatherFields.results.rawValue][WeatherFields.channel.rawValue][UnitFields.units.rawValue]
        distanceUnit = units[UnitFields.distance.rawValue].string
        pressureUnit = units[UnitFields.pressure.rawValue].string
        speedUnit = units[UnitFields.speed.rawValue].string
        temperatureUnit = units[UnitFields.temperature.rawValue].string
    }
}
