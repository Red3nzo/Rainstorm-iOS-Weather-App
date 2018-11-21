//
//  WeekViewModelTests.swift
//  RainstormTests
//
//  Created by Brandon Jacobi on 11/13/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import XCTest
@testable import Rainstorm

class WeekViewModelTests: XCTestCase {
    
    var viewModel: WeekViewModel!

    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "darksky", extension: "json")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let darkSkyResponse =  try! decoder.decode(DarkSkyResponse.self, from: data)
        
        viewModel = WeekViewModel(weatherData: darkSkyResponse.forecast)
        
    }

    override func tearDown() {
        super.tearDown()
        
    }

    func testNumberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    
    func testViewModelForIndex() {
        let weekDayViewModel = viewModel.viewModel(for: 5)
        XCTAssertEqual(weekDayViewModel.day, "Wednesday")
        XCTAssertEqual(weekDayViewModel.date, "November 318")
    }


}
