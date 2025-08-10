//
//  MapCamera.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import MapKit
import CoreLocation
import SwiftUI

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Sets the initial position on the map focusing on the user's location.
    /// This is typically called when the user opens the app for the first time.
    func positionToInitialUserLocation() {
        guard
            let position: MapCameraPosition = locationManager.getInitialMapCameraPosition(),
            let region: MKCoordinateRegion = position.region else {
            MapCameraErrorModel.failToGetInitialMapCameraPosition.errorDescription.debugLog()
            return
        }
        
        setPosition(region: region, animate: true)
    }
    
    /// Resets the map to the initial region bounds, removing markers and routes.
    /// The map animates smoothly back to the initial view.
    func resetMapToCurrentUserLocation() {
        // First, remove marker coordinates so it gets rid of the marker annotation and the radius circle on the map.
        removeMarkerCoordinate()
        
        // Then, remove route paths from the map if available.
        removeDirections()
        
        // Finally, animate the map back to the initial region bounds to provide a smooth user experience.
        withAnimation { positionToInitialUserLocation() }
    }
    
    /// Handles logic when the map camera changes continuously.
    /// - Parameter context: The camera update context containing the latest camera state.
    func onContinuousMapCameraChange(_ context: MapCameraUpdateContext) {
        setCameraDragging(true)
        setCenterCoordinate(context.camera.centerCoordinate)
    }
    
    /// Handles logic when the map camera stops moving.
    /// - Parameter context: The camera update context containing the final camera state.
    func onMapCameraChangeEnd(_ context: MapCameraUpdateContext) {
        setCameraDragging(false)
        setCenterCoordinate(context.camera.centerCoordinate)
        centerRegionBoundsForMarkerNUserLocation()
    }
    
    /// Cycles through available map styles and sets the next one.
    func setNextMapStyle() {
        let mapStylesArray: [MapStyleTypes] = MapStyleTypes.allCases
        guard let index: Int = mapStylesArray.firstIndex(where: { $0 == selectedMapStyle }) else {
            MapCameraErrorModel.failedToSetNextMapStyle.errorDescription.debugLog()
            return
        }
        
        let nextIndex: Int = mapStylesArray.nextIndex(after: index)
        selectedMapStyle = mapStylesArray[nextIndex]
    }
    
    // Sets the map region bounds to a given center and distance.
    /// - Parameters:
    ///   - center: The center coordinate for the new region.
    ///   - meters: The distance in meters for both latitude and longitude bounds.
    func setRegionBoundMeters(center: CLLocationCoordinate2D, meters: CLLocationDistance) {
        let region: MKCoordinateRegion = .init(center: center, latitudinalMeters: meters, longitudinalMeters: meters)
        setPosition(region: region, animate: true)
    }
    
    /// Centers the map region to fit both the marker and the user's location.
    /// If either is unavailable, logs an error instead.
    func centerRegionBoundsForMarkerNUserLocation() {
        guard let markerCoordinate, let currentUserLocation = locationManager.currentUserLocation else {
            MapCameraErrorModel.failedToCenterRegionBoundsForMarkerNUserLocation.errorDescription.debugLog()
            return
        }
        
        positionRegionBoundsToMidCoordinate(coordinate1: markerCoordinate, coordinate2: currentUserLocation, animate: true)
    }
}
