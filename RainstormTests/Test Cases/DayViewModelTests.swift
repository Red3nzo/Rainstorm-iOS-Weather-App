//
//  DayViewModelTests.swift
//  RainstormTests
//
//  Created by Brandon Jacobi on 11/13/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import XCTest
@testable import Rainstorm

class DayViewModelTests: XCTestCase {
    
    var viewModel: DayViewModel!

    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "darksky", extension: "json")
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        
        viewModel = DayViewModel(weatherData: darkSkyResponse.current)
        
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Fri, November 9 2018")
    }
    
    func testTime() {
        XCTAssertEqual(viewModel.time, "05:59 PM")
    }
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Partly Cloudy")
    }
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "66.7 °F")
    }
    
    func testWindSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "2 MPH")
    }

}
