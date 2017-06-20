//
//  WeatherAPIManagerTests.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/19/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import XCTest
import SwiftyJSON

class WeatherAPIManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWeatherAPICall() {
        
        let service = WeatherAPIManager()
        
        // We need to test an asynchronous callback
        let e = expectation(description: "Weather API")
        
        // Make asynchronous call
        service.weatherForLocation("austin, tx") { (json) in
            XCTAssert(json != JSON.null, "Failed to retrieve JSON")
            // We depend on the JSON to return a complete set of values.
            let object = WeatherObject(json: json)
            XCTAssertNotNil(object)
            if let printObject = object {
                debugPrint(printObject)
            }
            e.fulfill()
        }
        
        // Wait for expectation to be fulfilled
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
}
