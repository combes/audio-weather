//
//  WeatherModelProtocol.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/25/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import Foundation

protocol WeatherModelProtocol {
    var city: String { get }
    var conditionText: String { get }
    var temperature: String { get }
    var windDirection: String { get }
    var windChill: String { get }
    var windSpeed: String { get }
    var sunrise: String { get }
    var sunset: String { get }
}
