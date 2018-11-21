//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/8/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import Foundation

class RootViewModel: NSObject {
    
    enum WeatherDataError: Error {
        case notAuthorizedToFetchLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    enum WeatherDataResult {
        case success(WeatherData)
        case failure(WeatherDataError)
    }
    
    // MARK: - Type Aliases
    
    typealias FetchWeatherDataCompletion = (WeatherDataResult) -> Void
    
    // MARK: - Properties
    
    var didFetchWeatherData: FetchWeatherDataCompletion?
    
    private let locationService: LocationService
    
    init(locationService: LocationService) {
        self.locationService = locationService
        super.init()
        
        fetchWeatherData(for: Defaults.location)
        
        setupNotificationHandling()
        
        fetchLocation()
    }
    
    // MARK: - Helper Methods
    
    private func fetchLocation() {
        
        locationService.fetchLocation { [weak self] (result) in
            switch result {
            case .success(let location):
                self?.fetchWeatherData(for: location)
            case .failure(let error):
                print("Unable to Fetch Location (\(error))")
                
                let result: WeatherDataResult = .failure(.notAuthorizedToFetchLocation)
                
                self?.didFetchWeatherData?(result)
            }
        }
    }
    
    private func fetchWeatherData(for location: Location) {
        // Create URL
        let weatherRequest = WeatherRequest(baseURL: WeatherService.authenticatedBaseUrl, location: location)
        
        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to fetch weather data \(error)")
                    let result: WeatherDataResult = .failure(.noWeatherDataAvailable)
                    
                    // Invoke Completion handler
                    self?.didFetchWeatherData?(result)
                } else if let data = data {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()
                    
                    // Configure Decoding date for UNIX
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    do {
                        // Decoding JSON Response
                        let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                        
                        // Weather Data result
                        let result: WeatherDataResult = .success(darkSkyResponse)
                        
                        //Updates refresh time
                        UserDefaults.weatherDataRefreshTimestamp = Date()
                        
                        // Invoke Completion handler
                        self?.didFetchWeatherData?(result)
                    } catch {
                        print("Unable to Decode JSON Response \(error)")
                        // Weather Data Result
                        let result: WeatherDataResult = .failure(.noWeatherDataAvailable)
                        // Invoke completion handler
                        self?.didFetchWeatherData?(result)
                    }
                } else {
                    // Weather Data Result
                    let result: WeatherDataResult = .failure(.noWeatherDataAvailable)
                    
                    //Invoke completion handler
                    self?.didFetchWeatherData?(result)
                }
            }
        }.resume()
    }
    
    private func setupNotificationHandling() {
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillEnterForeground, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            guard let weatherDataRefreshTimestamp = UserDefaults.weatherDataRefreshTimestamp else {
                self?.refresh()
                return
            }
            
            if Date().timeIntervalSince(weatherDataRefreshTimestamp) > Configuration.refreshThreshold {
                self?.refresh()
            }
            
        }
    }
    
    func refresh() {
        fetchLocation()
    }
    
}

extension UserDefaults {
    
    private enum Keys {
        static let weatherDataRefreshTimestamp = "weatherDataRefreshTimestamp"
    }
    
    fileprivate class var weatherDataRefreshTimestamp: Date? {
        get {
            return UserDefaults.standard.object(forKey: Keys.weatherDataRefreshTimestamp) as? Date
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.weatherDataRefreshTimestamp)
        }
    }
    
}
