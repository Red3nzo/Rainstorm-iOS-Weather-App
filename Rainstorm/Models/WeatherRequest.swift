//
//  WeatherRequest.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/8/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import Foundation

struct WeatherRequest {
    
    let baseURL: URL
    
    let location: Location
    
    private var latitude: Double {
        return location.latitude
    }
    
    private var longitude: Double {
        return location.longitude
    }
    
    var url: URL {
        return baseURL.appendingPathComponent("\(latitude),\(longitude)")
    }
    
}
