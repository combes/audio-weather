//
//  ForecastModel.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/23/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import SwiftyJSON

class ForecastModel: ForecastModelProtocol, CustomDebugStringConvertible {
    var code = 0
    var date = Date()
    var day = "-"
    var high = "-"
    var low = "-"
    var condition = "-"
    
    var debugDescription: String {
        let description = "Day: \(day), code: \(code), date: \(date.description), high: \(high), low: \(low), text: \(condition)\n"
        return description
    }
    
    required init(json: JSON) {
        if let codeText = json[ForecastFields.code.rawValue].string {
            code = Int(codeText) ?? 0
        }
        // TODO: date = json[ForecastFields.date.rawValue]
        if let dayText = json[ForecastFields.day.rawValue].string {
            day = dayText
        }
        if let highText = json[ForecastFields.high.rawValue].string {
            high = highText
        }
        if let lowText = json[ForecastFields.low.rawValue].string {
            low = lowText
        }
        if let conditionText = json[ForecastFields.text.rawValue].string {
            condition = conditionText
        }
    }
}
