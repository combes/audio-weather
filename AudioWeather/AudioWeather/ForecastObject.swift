//
//  ForecastObject.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/23/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import SwiftyJSON

class ForecastObject: ForecastModelProtocol, CustomDebugStringConvertible {
    var code = 0
    var date = Date()
    var day: String
    var high: String
    var low: String
    var conditionText: String
    
    var debugDescription: String {
        let description = "Day: \(day), code: \(code), date: \(date.description), high: \(high), low: \(low), text: \(conditionText)\n"
        return description
    }
    
    required init(json: JSON) {
        if let codeText = json[ForecastFields.code.rawValue].string {
            code = Int(codeText) ?? 0
        }
        // TODO: date = json[ForecastFields.date.rawValue]
        day = json[ForecastFields.day.rawValue].string ?? "-"
        high = json[ForecastFields.high.rawValue].string ?? "-"
        low = json[ForecastFields.low.rawValue].string ?? "-"
        conditionText = json[ForecastFields.text.rawValue].string ?? "-"
    }
}
