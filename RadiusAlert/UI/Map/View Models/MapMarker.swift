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
    
    func addMarkerCoordinate(on type: MapTypes) -> String? {
        let markerCoordinate: CLLocationCoordinate2D? = {
            switch type {
            case .primary:
                return primaryCenterCoordinate
            case .secondary:
                return secondaryCenterCoordinate
            }
        }()
        
        let radius: CLLocationDistance = {
            switch type {
            case .primary:
                return primarySelectedRadius
            case .secondary:
                return secondarySelectedRadius
            }
        }()
        
        guard let markerCoordinate else { return nil }
        
        let marker: MarkerModel = .init(
            coordinate: markerCoordinate,
            radius: radius,
            route: nil,
            color: .debug
        )
        
        addMarker(marker)
        return marker.id
    }
    
    func setRegionBoundsToUserLocationNMarkers() {
        guard let userLocation: CLLocationCoordinate2D = locationManager.currentUserLocation else { return }
        
        var coordinates: [CLLocationCoordinate2D] = markers.map({ $0.coordinate })
        coordinates.append(userLocation)
        
        positionRegionBoundsToMidCoordinate(from: coordinates, on: .primary, animate: true)
    }
    
    func isThereAnyMarkerCoordinate() -> Bool {
        return !markers.isEmpty
    }
}
