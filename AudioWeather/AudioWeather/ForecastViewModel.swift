//
//  ForecastViewModel.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/23/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import Foundation

class ForecastViewModel: ForecastModelProtocol {
    // Protocol properties
    var code: Int
    var date: Date
    var day: String
    var high: String {
        get {
            return formattedTemperature(highText)
        }
    }
    var low: String {
        get {
            return formattedTemperature(lowText)
        }
    }
    var condition: String
    
    // Helper properties
    let temperatureUnits: String
    
    // Private properties
    private let highText: String
    private let lowText: String

    init(model: ForecastObject, temperatureUnits: String?) {
        code = model.code
        date = model.date
        day = model.day
        highText = model.high
        lowText = model.low
        condition = model.condition
        self.temperatureUnits = temperatureUnits ?? "?"
    }
    
    // MARK: Helper methods
    func formattedTemperature(_ text: String) -> String {
        return String(format: "%@°%@", text, temperatureUnits)
    }
}
