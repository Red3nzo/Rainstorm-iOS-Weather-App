//
//  LocationManger.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/14/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, LocationService {
    
    //MARK: -
    
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager
        locationManager.delegate = self
        return locationManager
    }()
    
    private var didFetchLocation: FetchLocationCompletion?
    
    func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
        didFetchLocation = completion
        
        locationManager.requestLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            let result: LocationServiceResult = .failure(.notAuthorizedToRequestLocation)
            didFetchLocation?(result)
            didFetchLocation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let result: LocationServiceResult = .success(Location(location: location))
        
        // Invoke Completion Handler
        didFetchLocation?(result)
        
        //Reset Completion Handler
        didFetchLocation = nil
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to Fetch Location (\(error))")
    }
    
}

fileprivate extension Location{
    
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
    
}
