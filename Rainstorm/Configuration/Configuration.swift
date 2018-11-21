//
//  Configuration.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/8/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import Foundation

enum Defaults {
    
    static let location = Location(latitude: 37.335114, longitude: -122.008928)
    
}

enum Configuration {
    
    static var refreshThreshold: TimeInterval {
        #if DUBUG
        return 60.0
        #else
        return 10.0 * 60.0
        #endif
    }
    
}

enum WeatherService {
    
    static let apiKey = "<ENTER DARKSKY API KEY HERE>"
    static let baseUrl = URL(string: "https://api.darksky.net/forecast/")!
    
    static var authenticatedBaseUrl: URL {
        return baseUrl.appendingPathComponent(apiKey)
    }
    
}
