//
//  UIViewController.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/8/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Static Properties
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}
