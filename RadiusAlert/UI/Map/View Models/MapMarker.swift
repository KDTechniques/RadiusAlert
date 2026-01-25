//
//  MapMarker.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import CoreLocation
import MapKit

// MARK: MAP MARKER

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func setRegionBoundsToUserLocationNMarkerCoordinate(animate: Bool = false) {
//        guard
//            let currentLocation = locationManager.currentUserLocation,
//            let markerCoordinate else { return }
//        
//        positionRegionBoundsToMidCoordinate(coordinate1: currentLocation, coordinate2: markerCoordinate, animate: animate)
    }
    
    func isThereAnyMarkerCoordinate() -> Bool {
        return !markers.isEmpty
    }
}
