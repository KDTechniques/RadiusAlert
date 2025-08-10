//
//  MapMarker.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import CoreLocation
import MapKit

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    func setMarkerCoordinate() {
        guard
            let currentLocation = locationManager.currentUserLocation,
            let centerCoordinate = centerCoordinate else { return }
        
        markerCoordinate = centerCoordinate
        positionRegionBoundsToMidCoordinate(coordinate1: centerCoordinate, coordinate2: currentLocation, animate: false)
    }
    
    func isMarkerCoordinateNil() -> Bool {
        return markerCoordinate == nil
    }
    
    func removeMarkerCoordinate() {
        markerCoordinate = nil
    }
}







