//
//  WeatherModel.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/17/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import SwiftyJSON

class WeatherModel: WeatherModelProtocol, CustomDebugStringConvertible {
    // Title
    var title = ""
    
    // Location
    var city = ""
    
    // Condition
    var code = 0
    var date = Date()
    var temperature = ""
    var conditionText = ""
    
    // Wind
    var windChill = ""
    var windDirection = ""
    var windSpeed = ""
    
    // Astronomy
    var sunrise = ""
    var sunset = ""
    
    var forecast = [ForecastModel]()
    
    var debugDescription: String {
        var description = ""
        description += "Title(\"\(title)\")\n"
        description += "City(\"\(city)\")\n"
        description += "Condition(code: \(code), date: \(date), temperature: \(temperature), text: \(conditionText))\n"
        description += "Wind(chill: \(windChill), direction: \(windDirection), speed: \(windSpeed))\n"
        description += "Astronomy(sunrise: \(sunrise), sunset: \(sunset))\n"
        description += "Forecast:\n"
        for day in forecast {
            description += day.debugDescription
        }
        return description
    }

    required init(json: JSON) {
        
        // Start of relevant JSON
        if json == JSON.null {
            return
        }
        // Must have JSON to parse
        let count = json[WeatherFields.query.rawValue][WeatherFields.count.rawValue].int
        if count == 0 {
            return
        }
        
        // Parse Channel
        var channel = json[WeatherFields.query.rawValue][WeatherFields.results.rawValue][WeatherFields.channel.rawValue]
        
        // Parse units
        let units = channel[UnitFields.units.rawValue]
        _ = UnitsModel(json: units)
        
        // Parse title
        title = channel[WeatherFields.title.rawValue].string ?? ""

        // Parse city
        city = channel[LocationFields.location.rawValue][LocationFields.city.rawValue].string ?? ""
        
        // Parse wind
        var wind = channel[WindFields.wind.rawValue]
        windChill = wind[WindFields.chill.rawValue].string  ?? ""
        windDirection = wind[WindFields.direction.rawValue].string  ?? ""
        windSpeed = wind[WindFields.speed.rawValue].string ?? ""
        
        // Parse astronomy
        var astronomy = channel[AstronomyFields.astronomy.rawValue]
        sunrise = astronomy[AstronomyFields.sunrise.rawValue].string  ?? ""
        sunset = astronomy[AstronomyFields.sunset.rawValue].string  ?? ""
        
        // Parse item with conditions
        var item = channel[WeatherFields.item.rawValue]
        var condition = item[ConditionFields.condition.rawValue]
        if let codeText = condition[ConditionFields.code.rawValue].string {
            code = Int(codeText) ?? 0
        }
        // TODO: date = condition[ConditionFields.date.rawValue]
        date = Date()
        temperature = condition[ConditionFields.temperature.rawValue].string  ?? ""
        conditionText = condition[ConditionFields.text.rawValue].string  ?? ""
                    

        // Parse forecast
        let forecastDays = item[ForecastFields.forecast.rawValue]
        for (_, day):(String, JSON) in forecastDays {
            forecast.append(ForecastModel(json: day))
        }
        
    }
}
