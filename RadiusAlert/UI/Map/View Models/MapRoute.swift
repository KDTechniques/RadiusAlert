//
//  MapRoute.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import MapKit

// MARK: ROUTE

extension MapViewModel {
    // MARK: -  PUBLIC FUNCTIONS
    func assignRoute(to id: String) {
        Task {
            guard
                let userLocation: CLLocationCoordinate2D = locationManager.currentUserLocation,
                var marker: MarkerModel = markers.first(where: { $0.id == id }),
                let route: MKRoute = await locationManager.getRoute(pointA: userLocation, pointB: marker.coordinate) else { return }
            
            marker.route = route
            
            updateMarker(at: id, value: marker)
        }
    }
}
