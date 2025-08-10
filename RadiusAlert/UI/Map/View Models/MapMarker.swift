//
//  MapMarker.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import CoreLocation

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    func setMarkerCoordinate() {
        guard
            let currentLocation = locationManager.currentUserLocation,
            let centerCoordinate = centerCoordinate else { return }
        
        markerCoordinate = centerCoordinate
        
        let distance: CLLocationDistance = getDistance(from: centerCoordinate, to: currentLocation)
        let boundsMeters: CLLocationDistance = distance * mapValues.regionBoundsFactor
        let midCoordinate: CLLocationCoordinate2D = calculateMidCoordinate(from: centerCoordinate, and: currentLocation)
        
        position = .region(.init(center: midCoordinate, latitudinalMeters: boundsMeters, longitudinalMeters: boundsMeters))
    }
    
    func isMarkerCoordinateNil() -> Bool {
        return markerCoordinate == nil
    }
    
    func removeMarkerCoordinate() {
        markerCoordinate = nil
    }
}
