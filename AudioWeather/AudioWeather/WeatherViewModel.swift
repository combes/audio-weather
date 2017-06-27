//
//  WeatherViewModel.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/25/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import Foundation

class WeatherViewModel: WeatherModelProtocol {
    // Protocol proprerties
    var city: String {
        get {
            return (cityText.characters.count == 0 ? "--" : cityText)
        }
    }
    var conditionText: String {
        get {
            return (conditionaryText.characters.count == 0 ? "--" : conditionaryText)
        }
    }
    var temperature: String {
        get {
            return UnitsViewModel.formattedTemperature(temperatureText)
        }
    }
    var windDirection: String {
        get {
            return windDirectionText.compassDirection()
        }
    }
    var windChill: String {
        get {
            return (windChillText.characters.count == 0 ? UnitsViewModel.formattedTemperature("-") : UnitsViewModel.formattedTemperature(windChillText))
        }
    }
    var windSpeed: String {
        get {
            return UnitsViewModel.formattedSpeed(windSpeedText)
        }
    }
    var sunrise: String {
        get {
            return sunriseText.characters.count == 0 ? "-- am" : sunriseText
        }
    }
    var sunset: String {
        get {
            return sunsetText.characters.count == 0 ? "-- pm" : sunsetText
        }
    }
    var date: String
    
    // Private properties
    private var cityText: String
    private var temperatureText: String
    private var conditionaryText: String
    private var windDirectionText: String
    private var windChillText: String
    private var windSpeedText: String
    private var sunriseText: String
    private var sunsetText: String
    
    init(model: WeatherModel) {
        cityText = model.city
        conditionaryText = model.conditionText
        temperatureText = model.temperature
        windDirectionText = model.windDirection
        windChillText = model.windChill
        windSpeedText = model.windSpeed
        sunriseText = model.sunrise
        sunsetText = model.sunset
        date = model.date
    }
    
    /// Derive background image based on sunrise, day, sunset, night
    ///
    /// - Returns: Image name based on current time
    static func backgroundImageName(sunriseHour: Int, sunsetHour: Int, currentHour: Int) -> String {
        // TODO:
//        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
//        let components = calendar?.components(NSCalendar.Unit.hour, from: date)
//        if let hour = components?.hour {
//            if hour > 5 && hour < 8 {
//                return "background-sunrise"
//            }
//            if hour > 17 && hour < 20 {
//                return "background-sunset"
//            }
//            if hour >= 8 && hour <= 17 {
//                return "background-day"
//            }
//        }
//        
        return "background-evening"
    }
}
