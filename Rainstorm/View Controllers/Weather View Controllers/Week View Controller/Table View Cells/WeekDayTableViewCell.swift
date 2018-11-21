//
//  WeekDayTableViewCell.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/13/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.RainStorm.base
        label.font = UIFont.RainStorm.heavyLarge
        label.text = "Thursday"
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.RainStorm.lightRegular
        label.text = "September 20"
        return label
    }()
    
    var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.RainStorm.lightSmall
        label.text = "55 MPH"
        return label
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.RainStorm.lightSmall
        label.text = "60 °F"
        return label
    }()
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.RainStorm.baseTintColor
        return imageView
    }()
    
    // MARK: - Helper Methods
    
    static var reuseIdentifier: String? {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(dayLabel)
        addSubview(dateLabel)
        addSubview(windSpeedLabel)
        addSubview(temperatureLabel)
        addSubview(iconImageView)
        
        dayLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: iconImageView.leadingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .zero)
        
        dateLabel.anchor(top: dayLabel.bottomAnchor, leading: dayLabel.leadingAnchor, bottom: nil, trailing: dayLabel.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
        
        temperatureLabel.anchor(top: nil, leading: dateLabel.leadingAnchor, bottom: bottomAnchor, trailing: windSpeedLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 8), size: .zero)
        
        windSpeedLabel.anchor(top: iconImageView.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: iconImageView.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 8, right: 0), size: .zero)
        
        iconImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: CGSize.init(width: 60.0, height: 60.0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with representable: WeekDayRepresentable) {
        dayLabel.text = representable.day
        dateLabel.text = representable.date
        windSpeedLabel.text = representable.windSpeed
        temperatureLabel.text = representable.temperature
        iconImageView.image = representable.image
    }
    
}
