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
            let route: MKRoute? = await locationManager.getRoute()
            setRoute(route)
        }
    }
    
    func removeDirections() {
        setRoute(nil)
    }
}
