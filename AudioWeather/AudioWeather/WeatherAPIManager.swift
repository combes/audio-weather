//
//  WeatherAPIManager.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/16/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, Error?) -> Void

// Fields are based on the Yahoo Weather API
enum WeatherFields: String {
    case query = "query"
    case results = "results"
    case channel = "channel"
    case title = "title"
    case item = "item"
}

enum ConditionFields: String {
    case condition = "condition"
    case code = "code"
    case date = "date"
    case temperature = "temp"
    case text = "text"
}

enum WindFields: String {
    case wind = "wind"
    case chill = "chill"
    case direction = "direction"
    case speed = "speed"
}

enum AstronomyFields: String {
    case astronomy = "astronomy"
    case sunrise = "sunrise"
    case sunset = "sunset"
}

enum ForecastFields: String {
    case forecast = "forecast"
    case code = "code"
    case date = "date"
    case day = "day"
    case high = "high"
    case low = "low"
    case text = "text"
}

enum UnitFields: String {
    case units = "units"
    case distance = "distance"
    case pressure = "pressure"
    case speed = "speed"
    case temperature = "temperature"
}

class WeatherAPIManager: NSObject {
    
    // Using public RSS feed from Yahoo Weather API
    let baseURL = "https://query.yahooapis.com/v1/public/yql?q="
    // Limiting "places" to 1 for simplicity
    let address = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"%@\")&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys)"

    func getWeatherForLocation(_ location: String, onCompletion: @escaping (JSON) -> Void) {
        // Create address path using provided location and format string
        let fullAddress = String(format: address, location)
        
        // Encode string for HTTP request
        if let escapedString = fullAddress.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            let route = baseURL + escapedString
            makeHTTPGetRequest(path: route, onCompletion: { json, err in
                onCompletion(json as JSON)
            })
        } else {
            onCompletion(JSON.null)
        }
    }
    
    // MARK: Perform GET Request
    private func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, error)
            } else {
                onCompletion(JSON.null, error)
            }
        })
        task.resume()
    }
}
