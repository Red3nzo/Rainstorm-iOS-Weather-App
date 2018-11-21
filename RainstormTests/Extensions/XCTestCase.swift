//
//  XCTestCase.swift
//  RainstormTests
//
//  Created by Brandon Jacobi on 11/13/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func loadStub(name: String, extension: String) -> Data {
        
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        return try! Data(contentsOf: url!)
    }
    
}
