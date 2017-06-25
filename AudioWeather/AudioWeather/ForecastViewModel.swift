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
            return UnitsViewModel.formattedTemperature(highText)
        }
    }
    var low: String {
        get {
            return UnitsViewModel.formattedTemperature(lowText)
        }
    }
    var condition: String
    
    // Private properties
    private let highText: String
    private let lowText: String

    init(model: ForecastModel) {
        code = model.code
        date = model.date
        day = model.day
        highText = model.high
        lowText = model.low
        condition = model.condition
    }
}
