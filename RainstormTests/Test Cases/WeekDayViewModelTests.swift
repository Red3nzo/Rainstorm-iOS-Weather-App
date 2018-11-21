//
//  WeekDayViewModelTests.swift
//  RainstormTests
//
//  Created by Brandon Jacobi on 11/13/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import XCTest
@testable import Rainstorm

class WeekDayViewModelTests: XCTestCase {
    
    var viewModel: WeekDayViewModel!
    
    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "darksky", extension: "json")
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        
        viewModel = WeekDayViewModel(weatherData: darkSkyResponse.forecast[5])
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDay() {
        XCTAssertEqual(viewModel.day, "Wednesday")
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "November 318")
    }
    
    func testTemerature() {
        XCTAssertEqual(viewModel.temperature, "53.4 °F - 67.3 °F")
    }
    
    func testWindSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "3 MPH")
    }

}
