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
    func onMarkerCoordinateChange(_ marker: CLLocationCoordinate2D?)  {
        locationManager.markerCoordinate = marker
        setAddPinOrAddMultipleStops(marker == nil ? .addPin : .addMultipleStops)
    }
    
    /// Updates the marker’s position on the map.
    /// - Sets the marker at the current center coordinate (if available).
    /// - Adjusts the map region bounds so that the marker and the user's current location
    ///   are both visible, without animation.
    func setMarkerCoordinate() {
        guard let centerCoordinate = centerCoordinate else { return }
        setMarkerCoordinate(centerCoordinate)
    }
    
    func setRegionBoundsToUserLocationNMarkerCoordinate(animate: Bool = false) {
        guard
            let currentLocation = locationManager.currentUserLocation,
            let markerCoordinate else { return }
        
        positionRegionBoundsToMidCoordinate(coordinate1: currentLocation, coordinate2: markerCoordinate, animate: animate)
    }
    
    func isMarkerCoordinateNil() -> Bool {
        return markerCoordinate == nil
    }
    
    func removeMarkerCoordinate() {
        setMarkerCoordinate(nil)
    }
}
