//
//  WeatherViewModelTests.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/27/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import XCTest
import SwiftyJSON

class WeatherViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBackgroundImage() {
        let viewModel = WeatherViewModel(model: WeatherModel(json: JSON.null))
        XCTAssertEqual(#imageLiteral(resourceName: "background-sunrise"),
                       viewModel.backgroundImage(sunriseHour: 6, sunsetHour: 18, currentHour: 7))
        XCTAssertEqual(#imageLiteral(resourceName: "background-sunset"),
                       viewModel.backgroundImage(sunriseHour: 6, sunsetHour: 18, currentHour: 19))
        XCTAssertEqual(#imageLiteral(resourceName: "background-day"),
                       viewModel.backgroundImage(sunriseHour: 6, sunsetHour: 18, currentHour: 12))
        XCTAssertEqual(#imageLiteral(resourceName: "background-evening"),
                       viewModel.backgroundImage(sunriseHour: 6, sunsetHour: 18, currentHour: 2))
    }
    
    /*
     if (abs(sunsetHour - currentHour) <= 1) {
     return "background-sunset"
     }
     if (currentHour > sunriseHour && currentHour < sunsetHour) {
     return "background-day"
     }
     
     return "background-evening"

     */
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
