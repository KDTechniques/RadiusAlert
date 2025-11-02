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
    func onMarkerCoordinateChange(_ marker: CLLocationCoordinate2D?)  {
        locationManager.markerCoordinate = marker
    }
    
    /// Updates the marker’s position on the map.
    /// - Sets the marker at the current center coordinate (if available).
    /// - Adjusts the map region bounds so that the marker and the user's current location
    ///   are both visible, without animation.
    func setMarkerCoordinate() {
        guard
            let currentLocation = locationManager.currentUserLocation,
            let centerCoordinate = centerCoordinate else { return }
        
        setMarkerCoordinate(centerCoordinate)
        positionRegionBoundsToMidCoordinate(coordinate1: centerCoordinate, coordinate2: currentLocation, animate: false)
    }
    
    func isMarkerCoordinateNil() -> Bool {
        return markerCoordinate == nil
    }
    
    func removeMarkerCoordinate() {
        setMarkerCoordinate(nil)
    }
}
