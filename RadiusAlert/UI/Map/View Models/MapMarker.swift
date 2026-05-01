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
    
    /// Returns a marker object for the given id.
    func getMarkerObject(on id: String) -> MarkerModel? {
        return markers.first(where: { $0.id == id })
    }
    
    /// Creates and adds a new marker based on the current map state.
    ///
    /// Uses either the selected search result or the map center coordinate,
    /// depending on how the user interacted with the map.
    ///
    /// - Important: The center coordinate is only used when the user manually moves the map.
    func addMarkerCoordinate(from type: MapTypes) -> String? {
        // Coordinate Check
        
        /// When getting the marker coordinate, don’t take it from the center coordinate as it can lead to incorrect values.
        /// This means when the user taps a predefined option like a location pin or a search result, the map might not move as intended.
        /// If it stops halfway, the intended coordinate and the center coordinate won’t match.
        /// The only case where we should use the center coordinate is when the user manually moves the map.
        let markerCoordinate: CLLocationCoordinate2D? = {
            switch type {
            case .primary:
                return selectedSearchResult?.result.coordinate ?? primaryCenterCoordinate
            case .secondary:
                return selectedSearchResult?.result.coordinate ?? secondaryCenterCoordinate
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
        
        // Make sure we're not adding the same marker on the same location
        guard !markers.contains(where: { $0.id == marker.id }) else {
            alertManager.showAlert(.markerAlreadyExist(viewLevel: .multipleStopsMapSheet))
            return nil
        }
        
        addMarker(marker)
        
        return marker.id
    }
    
    /// Adjusts the map region to include both user location and all markers.
    func setRegionBoundsToUserLocationNMarkers(on type: MapTypes) {
        guard let userLocation: CLLocationCoordinate2D = locationManager.currentUserLocation else { return }
        
        var coordinates: [CLLocationCoordinate2D] = markers.map({ $0.coordinate })
        coordinates.append(userLocation)
        
        positionRegionBoundsToMidCoordinate(from: coordinates, on: type, animate: true)
    }
    
    /// Returns whether there are any active markers.
    func isThereAnyMarkerCoordinate() -> Bool {
        return !markers.isEmpty
    }
    
    /// Updates a marker’s data when a linked location pin changes.
    func updateMarkerOnLocationPinChange(_ item: LocationPinsModel) {
        let markerID: String = item.coordinate.markerID()
        guard var marker: MarkerModel = getMarkerObject(on: markerID) else { return }
        
        marker.title = item.title
        updateMarker(at: markerID, value: marker)
    }
    
    /// Updates tip system states when markers change.
    func onChangeMapMarkers() {
        let markersCount: Int = markers.count
        
        RadiusSliderTipModel.markersCount = markersCount
        SettingsTipModel.markersCount = markersCount
        MapStyleButtonTipModel.markersCount = markersCount
    }
}
