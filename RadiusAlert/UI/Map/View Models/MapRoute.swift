//
//  MapRoute.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import MapKit

extension MapViewModel {
    // MARK: -  PUBLIC FUNCTIONS
    
    func getRoute() {
        Task {
            guard let route: MKRoute = await locationManager.getRoute() else { return }
            setRoute(route)
        }
    }
    
    func removeDirections() {
        clearRoutes()
    }
}
