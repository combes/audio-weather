//
//  AudioWeatherTests.swift
//  AudioWeatherTests
//
//  Created by Christopher Combes on 6/16/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import AudioWeather

class AudioWeatherTests: XCTestCase {
    
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
        service.getWeatherForLocation("austin, tx") { (json) in
            let object = WeatherObject(json: json)
            debugPrint(object)
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
