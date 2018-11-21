//
//  UIImage.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/13/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageForIcon(with name: String) -> UIImage? {
        switch name {
        case "clear-day",
             "clear-night",
             "fog",
             "rain",
             "snow",
             "sleet",
             "wind":
            return UIImage(named: name)
        case "cloudy",
             "partly-cloudy-day",
             "partly-cloudy-night":
            return UIImage(named: "cloudy")
        default:
            return UIImage(named: "clear-day")
        }
    }
}
