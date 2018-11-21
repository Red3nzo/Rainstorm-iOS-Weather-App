//
//  RootViewController.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/8/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum AlertType {
        case notAuthorizedToFetchLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            setupViewModel(with: viewModel)
        }
    }
    
    private let dayViewController: DayViewController = {
        let dayViewController = DayViewController()
        dayViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return dayViewController
    }()
    
    private lazy var weekViewController: WeekViewController = {
        let weekViewController = WeekViewController()
        weekViewController.delegate = self
        weekViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return weekViewController
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Child View Controller
        setupChildViewControllers()
        
    }
    
    //MARK: - Helper Methods
    
    private func setupChildViewControllers() {
        addChildViewController(dayViewController)
        addChildViewController(weekViewController)
        
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        dayViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dayViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dayViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor).isActive = true
        weekViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        weekViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        dayViewController.didMove(toParentViewController: self)
        weekViewController.didMove(toParentViewController: self)
    }
    
    private func setupViewModel(with viewModel: RootViewModel) {
        viewModel.didFetchWeatherData = { [weak self] (result) in
            
            switch result {
            case .success(let weatherData):
                // Init dayview model
                let dayViewModel = DayViewModel(weatherData: weatherData.current)
                
                // Upadte Day View Controller
                self?.dayViewController.viewModel = dayViewModel
                
                // Init weekViewModel
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                
                // Update Week View Controller
                self?.weekViewController.viewModel = weekViewModel
            case .failure(let error):
                let alertType: AlertType
                    
                switch error {
                case .notAuthorizedToFetchLocation:
                    alertType = .notAuthorizedToFetchLocation
                case .failedToRequestLocation:
                    alertType = .failedToRequestLocation
                case .noWeatherDataAvailable:
                    alertType = .noWeatherDataAvailable
                }
                
                self?.presentAlert(of: alertType)
                
                self?.dayViewController.viewModel = nil
                self?.weekViewController.viewModel = nil
            }
        }
    }
    
    private func presentAlert(of alertType: AlertType) {
        let title: String
        let message: String
        
        switch alertType {
        case .notAuthorizedToFetchLocation:
            title = "Unable to fetch weather data for your location."
            message = "Rainstorm is not authorized to access your current location. This means you will receive info for a default location. To access your location go to settings and allow location."
        case .failedToRequestLocation:
            title = "Unable to fetch weather data for your location."
            message = "Rainstorm is not able to fetch you current location due to a technical issue."
        case .noWeatherDataAvailable:
            title = "Unable to fetch weather data"
            message = "The application is unable to fetch weather data. Please make sure you are connect to Wi-Fi or LTE."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
        
    }
    
}

extension RootViewController: WeekViewControllerDelegate {
    
    func controllerDidRefresh(_ controller: WeekViewController) {
        viewModel?.refresh()
    }
    
}
