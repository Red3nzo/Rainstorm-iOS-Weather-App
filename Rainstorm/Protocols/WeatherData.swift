//
//  WeatherData.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/11/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import Foundation

protocol WeatherData {
    
    var latitude: Double { get }
    var longitude: Double { get }
    
    var current: CurrentWeatherConditions { get }
    var forecast: [ForecastWeatherConditions] { get }
    
}

protocol WeatherConditions {
    
    var time: Date { get }
    var icon: String { get }
    var windSpeed: Double { get }
    
}

protocol CurrentWeatherConditions: WeatherConditions {
    
    var summary: String { get }
    var temperature: Double { get }
    
}

protocol ForecastWeatherConditions: WeatherConditions {
    
    var temperatureMin: Double { get }
    var temperatureMax: Double { get }
    
}
