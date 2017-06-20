//
//  WeatherObject.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/17/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import SwiftyJSON

class ForecastObject: CustomDebugStringConvertible {
    var code = 0
    var date: Date!
    var day: String!
    var high: String!
    var low: String!
    var text: String!
    
    var debugDescription: String {
        var description = ""
        if let dateValue = date, let dayValue = day, let textValue = text {
            description = "Day: \(dayValue), code: \(code), date: \(dateValue.description), high: \(high), low: \(low), text: \(textValue)\n"
        }
        return description
    }
    
    required init(json: JSON) {
        if let codeText = json[ForecastFields.code.rawValue].string {
            code = Int(codeText) ?? 0
        }
        // TODO: date = json[ForecastFields.date.rawValue]
        date = Date()
        day = json[ForecastFields.day.rawValue].string
        high = json[ForecastFields.high.rawValue].string
        low = json[ForecastFields.low.rawValue].string
        text = json[ForecastFields.text.rawValue].string
    }
}

class WeatherObject: CustomDebugStringConvertible {
    
    // Title
    var title: String!
    
    // Units
    var distanceUnit: String!
    var pressureUnit: String!
    var speedUnit: String!
    var temperatureUnit: String!
    
    // Location
    var city: String!
    
    // Condition
    var code = 0
    var date: Date!
    var temperature: String!
    var conditionText: String!
    
    // Wind
    var windChill: String!
    var windDirection: String!
    var windSpeed = 0.0
    
    // Astronomy
    var sunrise: String!
    var sunset: String!
    
    var forecast = [ForecastObject]()
    
    var debugDescription: String {
        var description = ""
        if let titleValue = title {
            description += "Title(\"\(titleValue)\")\n"
        }
        if let cityValue = city {
            description += "City(\"\(cityValue)\")\n"
        }
        if let distanceValue = distanceUnit, let pressureValue = pressureUnit, let speedValue = speedUnit, let temperatureValue = temperatureUnit {
            description += "Units(distance: \(distanceValue), pressure: \(pressureValue), speed: \(speedValue), temperature: \(temperatureValue))\n"
        }
        if let dateValue = date, let temperatureValue = temperature, let conditionValue = conditionText {
            description += "Condition(code: \(code), date: \(dateValue), temperature: \(temperatureValue), text: \(conditionValue))\n"
        }
        if let chillValue = windChill {
            description += "Wind(chill: \(chillValue), direction: \(windDirection), speed: \(windSpeed))\n"
        }
        if let sunriseValue = sunrise, let sunsetValue = sunset {
            description += "Astronomy(sunrise: \(sunriseValue), sunset: \(sunsetValue))\n"
        }
        description += "Forecast:\n"
        for day in forecast {
            description += day.debugDescription
        }
        return description
    }

    // TODO: If we really want to be pedantic we can make this a failable initializer.
    required init(json: JSON) {
        
        // Start of relevant JSON
        var channel = json[WeatherFields.query.rawValue][WeatherFields.results.rawValue][WeatherFields.channel.rawValue]
        
        // Parse units
        var units = channel[UnitFields.units.rawValue]
        distanceUnit = units[UnitFields.distance.rawValue].string
        pressureUnit = units[UnitFields.pressure.rawValue].string
        speedUnit = units[UnitFields.speed.rawValue].string
        temperatureUnit = units[UnitFields.temperature.rawValue].string
            
        // Parse title
        title = channel[WeatherFields.title.rawValue].string

        // Parse city
        city = channel[LocationFields.city.rawValue].string
        
        // Parse wind
        var wind = channel[WindFields.wind.rawValue]
        windChill = wind[WindFields.chill.rawValue].string
        windDirection = wind[WindFields.direction.rawValue].string
        if let speedText = wind[WindFields.speed.rawValue].string {
            windSpeed = Double(speedText) ?? 0
        }
        
        // Parse astronomy
        var astronomy = channel[AstronomyFields.astronomy.rawValue]
        sunrise = astronomy[AstronomyFields.sunrise.rawValue].string
        sunset = astronomy[AstronomyFields.sunset.rawValue].string
        
        // Parse item with conditions
        var item = channel[WeatherFields.item.rawValue]
        var condition = item[ConditionFields.condition.rawValue]
        if let codeText = condition[ConditionFields.code.rawValue].string {
            code = Int(codeText) ?? 0
        }
        // TODO: date = condition[ConditionFields.date.rawValue]
        date = Date()
        temperature = condition[ConditionFields.temperature.rawValue].string
        conditionText = condition[ConditionFields.text.rawValue].string
                    

        // Parse forecast
        let forecastDays = item[ForecastFields.forecast.rawValue]
        for (_, day):(String, JSON) in forecastDays {
            forecast.append(ForecastObject(json: day))
        }
        
    }
}
