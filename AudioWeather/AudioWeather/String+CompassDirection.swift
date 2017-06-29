//
//  String+CompassDirection.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/25/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import Foundation

extension String {
    func compassDirection(fullDescription: Bool = false) -> String {
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
            direction = fullDescription ? "North" : "N"
        } else if value >= 11.25 && value <= 33.75 {
            direction = fullDescription ? "North Northeast" : "NNE"
        } else if value >= 33.75 && value <= 56.25 {
            direction = fullDescription ? "Northeast" : "NE"
        } else if value >= 56.25 && value <= 78.75 {
            direction = fullDescription ? "East Northeast" : "ENE"
        } else if value >= 78.75 && value <= 101.25 {
            direction = fullDescription ? "East" : "E"
        } else if value >= 101.25 && value <= 123.75 {
            direction = fullDescription ? "East Southeast" : "ESE"
        } else if value >= 123.75 && value <= 146.25 {
            direction = fullDescription ? "Southeast" : "SE"
        } else if value >= 146.25 && value <= 168.75 {
            direction = fullDescription ? "South Southest" : "SSE"
        } else if value >= 168.75 && value <= 191.25 {
            direction = fullDescription ? "South" : "S"
        } else if value >= 191.25 && value <= 213.75 {
            direction = fullDescription ? "South Southwest" : "SSW"
        } else if value >= 213.75 && value <= 236.25 {
            direction = fullDescription ? "Southwest" : "SW"
        } else if value >= 236.25 && value <= 258.75 {
            direction = fullDescription ? "West Southwest" : "WSW"
        } else if value >= 258.75 && value <= 281.25 {
            direction = fullDescription ? "West" : "W"
        } else if value >= 281.25 && value <= 303.75 {
            direction = fullDescription ? "West Northwest" : "WNW"
        } else if value >= 303.75 && value <= 326.25 {
            direction = fullDescription ? "Northwest" : "NW"
        } else if value >= 326.25 && value <= 348.75 {
            direction = fullDescription ? "North Northwest" : "NNW"
        }
        
        return direction
    }
}
