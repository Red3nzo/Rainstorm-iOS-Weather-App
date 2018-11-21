//
//  WeekViewModel.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/11/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import Foundation

struct WeekViewModel {
    
    let weatherData: [ForecastWeatherConditions]
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    func viewModel(for index: Int) -> WeekDayViewModel {
        return WeekDayViewModel(weatherData: weatherData[index])
    }
    
}
