//
//  LocationService.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/14/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import Foundation

enum LocationServiceError {
    case notAuthorizedToRequestLocation
}

enum LocationServiceResult {
    case success(Location)
    case failure(LocationServiceError)
}

protocol LocationService {
    
    typealias FetchLocationCompletion = (LocationServiceResult) -> Void
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
    
}

