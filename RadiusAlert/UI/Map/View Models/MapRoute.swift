//
//  MapRoute.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import Foundation

extension MapViewModel {
    // MARK: -  PUBLIC FUNCTIONS
    func getDirections() {
        Task { route = await locationManager.getDirections() }
    }
    
    func removeDirections() {
        route = nil
    }
}
