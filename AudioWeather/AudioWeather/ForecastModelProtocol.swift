//
//  ForecastModelProtocol.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/23/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import Foundation

protocol ForecastModelProtocol {
    var code: Int { get }
    var date: Date { get }
    var day: String { get }
    var high: String { get }
    var low: String { get }
    var conditionText: String { get }
}
