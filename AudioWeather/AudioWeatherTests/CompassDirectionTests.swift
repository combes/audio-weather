//
//  CompassDirectionTests.swift
//  AudioWeather
//
//  Created by Christopher Combes on 6/25/17.
//  Copyright © 2017 Christopher Combes. All rights reserved.
//

import XCTest

class CompassDirectionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCompassDirection() {
        let testCases = [
            "xy"  : "?",
            "350" : "N",
            "175" : "S",
            "90"  : "E",
            "271" : "W",
            "102" : "ESE",
            "282" : "WNW"
        ]
        
        for (test, result) in testCases {
            let value = test.compassDirection()
            XCTAssert(value == result, "Compass direction invalid \(test) -> \(value) should be \(result)")
        }
    }
}
