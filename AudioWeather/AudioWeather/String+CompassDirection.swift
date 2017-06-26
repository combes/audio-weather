//
//  String+CompassDirection.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/25/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import Foundation

extension String {
    func compassDirection() -> String {
        var direction = "?"
        
        // Must have a type Double to work with
        guard let value = Double(self)  else {
            return direction
        }
        
        /*
         16-point Compass
         
         N      348.75 - 11.25
         NNE    11.25 - 33.75
         NE     33.75 - 56.25
         ENE    56.25 - 78.75
         E      78.75 - 101.25
         ESE    101.25 - 123.75
         SE     123.75 - 146.25
         SSE    146.25 - 168.75
         S      168.75 - 191.25
         SSW    191.25 - 213.75
         SW     213.75 - 236.25
         WSW    236.25 - 258.75
         W      258.75 - 281.25
         WNW    281.25 - 303.75
         NW     303.75 - 326.25
         NNW    326.25 - 348.75
         */
        if value >= 348.75 || (value >= 0 && value <= 11.25) {
            direction = "N"
        } else if value >= 11.25 && value <= 33.75 {
            direction = "NNE"
        } else if value >= 33.75 && value <= 56.25 {
            direction = "NE"
        } else if value >= 56.25 && value <= 78.75 {
            direction = "ENE"
        } else if value >= 78.75 && value <= 101.25 {
            direction = "E"
        } else if value >= 101.25 && value <= 123.75 {
            direction = "ESE"
        } else if value >= 123.75 && value <= 146.25 {
            direction = "SE"
        } else if value >= 146.25 && value <= 168.75 {
            direction = "SSE"
        } else if value >= 168.75 && value <= 191.25 {
            direction = "S"
        } else if value >= 191.25 && value <= 213.75 {
            direction = "SSW"
        } else if value >= 213.75 && value <= 236.25 {
            direction = "SW"
        } else if value >= 236.25 && value <= 258.75 {
            direction = "WSW"
        } else if value >= 258.75 && value <= 281.25 {
            direction = "W"
        } else if value >= 281.25 && value <= 303.75 {
            direction = "WNW"
        } else if value >= 303.75 && value <= 326.25 {
            direction = "NW"
        } else if value >= 326.25 && value <= 348.75 {
            direction = "NNW"
        }
        
        return direction
    }
}
