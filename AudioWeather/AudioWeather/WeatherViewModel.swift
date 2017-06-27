//
//  WeatherViewModel.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/25/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import UIKit

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
    
    func backgroundImage() -> UIImage {
        return backgroundImage(sunriseHour: hourUsingTimeFormat(timeText: sunrise),
                               sunsetHour: hourUsingTimeFormat(timeText: sunset),
                               currentHour: hourUsingWeatherFormat(dateText: date))
    }
    
    /// Derive background image based on sunrise, day, sunset, night
    ///
    /// - Returns: Image name based on current time
    func backgroundImage(sunriseHour: Int, sunsetHour: Int, currentHour: Int) -> UIImage {
        if (abs(sunriseHour - currentHour) <= 1) {
            return #imageLiteral(resourceName: "background-sunrise")
        }
        if (abs(sunsetHour - currentHour) <= 1) {
            return #imageLiteral(resourceName: "background-sunset")
        }
        if (currentHour > sunriseHour && currentHour < sunsetHour) {
            return #imageLiteral(resourceName: "background-day")
        }

        return #imageLiteral(resourceName: "background-evening")
    }
    
    // MARK: Helper methods
    func hourUsingWeatherFormat(dateText: String) -> Int {
        var hour = 0
        
        var textComponents = dateText.components(separatedBy: " ")
        textComponents.removeLast()
        let newText = textComponents.joined(separator: " ")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, d MMM yyyy hh:mm a"
        
        if let checkDate = dateFormatter.date(from: newText) {
            let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let components = calendar?.components(NSCalendar.Unit.hour, from: checkDate)
            hour = components?.hour ?? 0
        }
        
        return hour
    }
    
    func hourUsingTimeFormat(timeText: String) -> Int {
        var hour = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        if let checkDate = dateFormatter.date(from: timeText) {
            let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let components = calendar?.components(NSCalendar.Unit.hour, from: checkDate)
            hour = components?.hour ?? 0
        }
        
        return hour
    }
}
