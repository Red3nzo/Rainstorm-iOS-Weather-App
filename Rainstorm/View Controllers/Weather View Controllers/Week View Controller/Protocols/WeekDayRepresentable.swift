//
//  WeekDayRepresentable.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/13/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import UIKit

protocol WeekDayRepresentable {
    
    var day: String { get }
    var date: String { get }
    var temperature: String { get }
    var windSpeed: String { get }
    var image: UIImage? { get }
    
}
