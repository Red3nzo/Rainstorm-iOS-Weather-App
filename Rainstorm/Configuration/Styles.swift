//
//  Styles.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/12/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import UIKit

extension UIColor {
    
    enum RainStorm {
     
        static let base: UIColor = UIColor(red: 0.31, green: 0.72, blue: 0.83, alpha: 1.0)
        
        static var baseTintColor: UIColor {
            return base
        }
        
        static var lightBackgroundColor: UIColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1.0)
        
    }
    
}

extension UIFont {
    
    enum RainStorm {
        
        static let lightRegular: UIFont = .systemFont(ofSize: 17.0, weight: .light)
        static let lightSmall: UIFont = .systemFont(ofSize: 15.0, weight: .light)
        static let heavyLarge: UIFont = .systemFont(ofSize: 20.0, weight: .heavy)
        
    }
    
}
