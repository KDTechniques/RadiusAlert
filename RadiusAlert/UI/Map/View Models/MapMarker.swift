//
//  MapMarker.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import CoreLocation
import MapKit
import SwiftUI

// MARK: MAP MARKER

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func getMarkerObject(on id: String) -> MarkerModel? {
        return markers.first(where: { $0.id == id })
    }
    
    func addMarkerCoordinate(from type: MapTypes) -> String? {
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
        
        let title: String? = selectedSearchResult?.result.name
        
        let marker: MarkerModel = .init(
            title: title,
            coordinate: markerCoordinate,
            radius: radius,
            color: markers.isEmpty ? .pink : .debug,
            number: (markers.map({ $0.number }).max() ?? 0) + 1
        )
        
        addMarker(marker)
        
        return marker.id
    }
    
    func setRegionBoundsToUserLocationNMarkers(on type: MapTypes) {
        guard let userLocation: CLLocationCoordinate2D = locationManager.currentUserLocation else { return }
        
        var coordinates: [CLLocationCoordinate2D] = markers.map({ $0.coordinate })
        coordinates.append(userLocation)
        
        positionRegionBoundsToMidCoordinate(from: coordinates, on: type, animate: true)
    }
    
    func isThereAnyMarkerCoordinate() -> Bool {
        return !markers.isEmpty
    }
}
