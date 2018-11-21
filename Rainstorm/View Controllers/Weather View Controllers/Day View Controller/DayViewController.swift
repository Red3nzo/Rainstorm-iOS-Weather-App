//
//  DayViewController.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/8/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import UIKit

final class DayViewController: UIViewController {
    
    //MARK: - View Models
    
    var viewModel: DayViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            setupViewModel(with: viewModel)
            
        }
    }
    
    // MARK: - UI Properties
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.RainStorm.base
        label.font = UIFont.RainStorm.heavyLarge
        label.text = "Label"
        label.isHidden = true
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.RainStorm.lightSmall
        label.text = "18th 2000"
        label.isHidden = true
        return label
    }()
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.RainStorm.baseTintColor
        imageView.isHidden = true
        return imageView
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.RainStorm.lightRegular
        label.text = "20"
        label.isHidden = true
        return label
    }()
    
    var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.RainStorm.lightRegular
        label.textAlignment = .right
        label.text = "55 MPH"
        label.isHidden = true
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.RainStorm.lightSmall
        label.text = "Windy as hell"
        label.isHidden = true
        return label
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    
    //MARK: View Methods
    
    private func setupView() {
        
        view.addSubview(dateLabel)
        view.addSubview(timeLabel)
        view.addSubview(iconImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(descriptionLabel)
        //view.addSubview(activityIndicatorView)
        
        dateLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 8, left: 0, bottom: 0, right: 0), size: .zero)
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        timeLabel.anchor(top: dateLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 8, left: 0, bottom: 0, right: 0), size: .zero)
        timeLabel.centerXAnchor.constraint(equalTo: dateLabel.centerXAnchor).isActive = true
        
        iconImageView.anchor(top: timeLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 60.0, height: 60.0))
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        temperatureLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: iconImageView.leadingAnchor, padding: UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 8), size: .zero)
        temperatureLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        
        windSpeedLabel.anchor(top: nil, leading: iconImageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 16), size: .zero)
        windSpeedLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        
        descriptionLabel.anchor(top: iconImageView.bottomAnchor, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: UIEdgeInsets.init(top: 20, left: 0, bottom: 20, right: 0), size: .zero)
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //activityIndicatorView.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor).isActive = true
        //activityIndicatorView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        
        view.backgroundColor = UIColor.RainStorm.lightBackgroundColor
    }
    
    private func unhideViews() {
        let isViewHidden = false
        
        dateLabel.isHidden = isViewHidden
        timeLabel.isHidden = isViewHidden
        windSpeedLabel.isHidden = isViewHidden
        temperatureLabel.isHidden = isViewHidden
        descriptionLabel.isHidden = isViewHidden
        iconImageView.isHidden = isViewHidden
        
    }
    
    private func setupViewModel(with viewModel: DayViewModel) {
        //activityIndicatorView.stopAnimating()
        
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        windSpeedLabel.text = viewModel.windSpeed
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.summary
        iconImageView.image = viewModel.image
        
        unhideViews()
        
    }
    
}
