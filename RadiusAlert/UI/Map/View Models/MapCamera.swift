//
//  MapCamera.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import MapKit
import CoreLocation
import SwiftUI

// MARK: CAMERA

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Sets the initial position on the map focusing on the user's location.
    /// This is typically called when the user opens the app for the first time or map renders.
    func positionToInitialUserLocation(on type: MapTypes, animate: Bool) {
        guard
            let position: MapCameraPosition = locationManager.getInitialMapCameraPosition(),
            let region: MKCoordinateRegion = position.region else {
            Utilities.log(MapCameraErrorModel.failToGetInitialMapCameraPosition.errorDescription)
            return
        }
        
        Task {
            switch type {
            case .primary:
                await setPrimaryPosition(region: region, animate: animate)
            case .secondary:
                await setSecondaryPosition(region: region, animate: animate)
            }
        }
    }
    
    /// Positions the map region so that both coordinates are visible, centered at their midpoint.
    /// - Parameters:
    ///   - coordinate1: The first location coordinate.
    ///   - coordinate2: The second location coordinate.
    ///   - animate: Whether the map camera movement should be animated.
    func positionRegionBoundsToMidCoordinate(from coordinates: [CLLocationCoordinate2D], on type: MapTypes, animate: Bool) {
        guard coordinates.count >= 2 else { return }
        
        // Find the midpoint between the coordinates.
        let midCoordinate: CLLocationCoordinate2D = Utilities.calculateMidCoordinate(from: coordinates)
        
        // Calculate the max distance between coordinates.
        let distance: CLLocationDistance = Utilities.getDistance(by: .max, from: coordinates)
        
        // Determine the bounds size so both annotations are visible.
        let boundsMeters: CLLocationDistance = distance * mapValues.regionBoundsFactor
        
        // Create a region centered at the midpoint with the calculated bounds.
        let region: MKCoordinateRegion = .init(
            center: midCoordinate,
            latitudinalMeters: boundsMeters,
            longitudinalMeters: boundsMeters
        )
        
        // Update the map position.
        Task {
            switch type {
            case .primary:
                await setPrimaryPosition(region: region, animate: animate)
            case .secondary:
                await setSecondaryPosition(region: region, animate: animate)
            }
        }
    }
    
    /// Returns a binding to the current map camera position.
    /// - Returns: A `Binding` to `MapCameraPosition` that updates the map region when set.
    func primaryPositionBinding() -> Binding<MapCameraPosition> {
        return .init(get: { self.primaryPosition }, set: setPrimaryPosition)
    }
    
    /// Returns a binding to the secondary map camera position.
    /// - Returns: A `Binding` to `MapCameraPosition` that updates the map region when set.
    func secondaryPositionBinding() -> Binding<MapCameraPosition> {
        return .init(get: { self.secondaryPosition }, set: setSecondaryPosition)
    }
    
    /// Handles logic when the map camera changes continuously.
    /// - Parameter context: The camera update context containing the latest camera state.
    func onContinuousMapCameraChange(for type: MapTypes, _ context: MapCameraUpdateContext) {
        switch type {
        case .primary:
            guard isAuthorizedToGetMapCameraUpdate else { return }
            setPrimaryCameraDragging(true)
            setPrimaryCenterCoordinate(context.camera.centerCoordinate)
            
        case .secondary:
            setSecondaryCameraDragging(true)
            setSecondaryCenterCoordinate(context.region.center)
        }
    }
    
    /// Handles logic when the map camera stops moving.
    /// - Parameter context: The camera update context containing the final camera state.
    func onMapCameraChangeEnd(for type: MapTypes, _ context: MapCameraUpdateContext) {
        switch type {
        case .primary:
            guard isAuthorizedToGetMapCameraUpdate else { return }
            setPrimaryCameraDragging(false)
            setPrimaryCenterCoordinate(context.camera.centerCoordinate)
            
        case .secondary:
            setSecondaryCameraDragging(false)
            setSecondaryCenterCoordinate(context.camera.centerCoordinate)
        }
        
        clearSelectedSearchResultItemOnMapCameraChangeByUser(on: type)
    }
    
    /// Cycles through available map styles and sets the next one.
    func setNextMapStyle() {
        let mapStylesArray: [MapStyleTypes] = MapStyleTypes.allCases
        guard let index: Int = mapStylesArray.firstIndex(where: { $0 == settingsVM.selectedMapStyle }) else {
            Utilities.log(MapCameraErrorModel.failedToSetNextMapStyle.errorDescription)
            return
        }
        
        let nextIndex: Int = mapStylesArray.nextIndex(after: index)
        settingsVM.setSelectedMapStyle(mapStylesArray[nextIndex])
    }
    
    // Sets the map region bounds to a given center and distance.
    /// - Parameters:
    ///   - center: The center coordinate for the new region.
    ///   - meters: The distance in meters for both latitude and longitude bounds.
    func setRegionBoundMeters(to centerCoordinate: CLLocationCoordinate2D, meters: CLLocationDistance, on type: MapTypes, animate: Bool) async {
        let region: MKCoordinateRegion = .init(center: centerCoordinate, latitudinalMeters: meters, longitudinalMeters: meters)
        
        switch type {
        case .primary:
            await setPrimaryPosition(region: region, animate: animate)
        case .secondary:
            await setSecondaryPosition(region: region, animate: animate)
        }
    }
    
    /// Registers a cleanup action to help clear memory related to map styles.
    /// When triggered by a memory warning, it cycles through three map styles
    /// with short delays between each change to release cached map resources.
    func clearMemoryByMapStyles() {
        memoryWarningsHandler.registerCleanupAction {
            Task { @MainActor in
                for _ in 1...3 {
                    self.setNextMapStyle()
                    try? await Task.sleep(nanoseconds: 100_000_000)
                }
            }
        }
    }
    
    func positionMapOnAuthorization(authorizationStatus: CLAuthorizationStatus) {
        // Updates internal state based on current authorization status.
        setIsAuthorizedToGetMapCameraUpdate(authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse)
        
        // Skips map update if not authorized.
        guard isAuthorizedToGetMapCameraUpdate else { return }
        
        // Delays then repositions the map to the initial user location on the main actor.
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            positionToInitialUserLocation(on: .primary, animate: true)
        }
    }
    
    func autoPositionMarkersNUserLocationRegionBounds() {
        guard !markers.isEmpty else { return }
        let currentTime: Date = .now
        let timeDiff: Double = currentTime.timeIntervalSince(regionBoundsToUserLocationNMarkersTimestamp)
        let timeCondition: Double = 10 // 10 seconds
        
        guard timeDiff >= timeCondition else { return }
        setRegionBoundsToUserLocationNMarkers(on: .primary)
        setRegionBoundsToUserLocationNMarkersTimestamp(.now)
    }
    
    func prepareMapPositionNRegion(on type: MapTypes, mapItem: MKMapItem, itemRadius: CLLocationDistance) async {
        let centerCoordinate: CLLocationCoordinate2D? = {
            switch type {
            case .primary:
                return primaryCenterCoordinate
            case .secondary:
                return secondaryCenterCoordinate
            }
        }()
        
        guard let centerCoordinate else { return }
        
        // 1) Zoom out to Initial Region Bounds
        let boundsMeters: CLLocationDistance = mapValues.initialUserLocationBoundsMeters
        let initialRegion: MKCoordinateRegion = .init(
            center: centerCoordinate,
            latitudinalMeters: boundsMeters,
            longitudinalMeters: boundsMeters
        )
        
        switch type {
        case .primary:
            await setPrimaryPosition(region: initialRegion, animate: true)
            break
        case .secondary:
            await setSecondaryPosition(region: initialRegion, animate: true)
        }
        
        // 2) Position Camera to New Coordinates
        let newRegion: MKCoordinateRegion = .init(
            center: mapItem.placemark.coordinate,
            latitudinalMeters: boundsMeters,
            longitudinalMeters: boundsMeters
        )
        
        /// View get affected due to following radius changes, because of that position doesn't update with animation properly.
        /// A small delay help the position to animate properly after the view update was ended from the radius value.
        switch type {
        case .primary:
            setPrimarySelectedRadius(itemRadius)
            try? await Task.sleep(nanoseconds: 300_000_000)
            await setPrimaryPosition(region: newRegion, animate: true)
            
        case .secondary:
            setSecondarySelectedRadius(itemRadius)
            try? await Task.sleep(nanoseconds: 300_000_000)
            await setSecondaryPosition(region: newRegion, animate: true)
        }
        
        setSelectedSearchResult(.init(result: mapItem))
        
        // 3) Zoom in or out to region bounds based on radius
        await setRegionBoundsOnRadius(for: type)
        
        setSelectedSearchResult(.init(result: mapItem, doneSetting: true))
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Check the coordinates between selectedMapItem and the center coordinate.
    /// If these two don’t match, it means the user has moved the map around,
    /// and it is no longer the selected search result coordinate.
    /// Clears the selected search result if the map camera position no longer matches the selected search result's coordinate.
    private func clearSelectedSearchResultItemOnMapCameraChangeByUser(on type: MapTypes) {
        let centerCoordinate: CLLocationCoordinate2D? = {
            switch type {
            case .primary:
                return primaryCenterCoordinate
            case .secondary:
                return secondaryCenterCoordinate
            }
        }()
        
        guard
            let centerCoordinate,
            let selectedSearchResult,
            !selectedSearchResult.result.coordinate.isEqual(to: centerCoordinate),
            selectedSearchResult.doneSetting else { return }
        
        // Clear the selected search result because the user moved the map away from it
        setSelectedSearchResult(nil)
    }
}
