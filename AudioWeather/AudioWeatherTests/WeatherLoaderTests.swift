//
//  WeatherLoaderTests.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/19/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import XCTest
@testable import AudioWeather

class WeatherLoaderTests: XCTestCase {
    var expectRefresh: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        NotificationCenter.default.addObserver(self, selector: #selector(dataLoaded), name: .weatherNotification, object: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        NotificationCenter.default.removeObserver(self)
        super.tearDown()
    }
    
    func testLocation() {
        let someplace = "Someplace"
        WeatherLoader().location = someplace
        let location = WeatherLoader().location
        XCTAssertEqual(someplace, location)
    }
    
    func testRefresh() {
        // We need to test an asynchronous callback
        expectRefresh = expectation(description: "Weather API")
        
        // Refresh weather data
        WeatherLoader().refresh()
        
        // Wait for expectation to be fulfilled
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            
            self.expectRefresh = nil
        }
    }
    
    func dataLoaded() {
        if (expectRefresh != nil) {
            expectRefresh?.fulfill()
        }
    }
}
