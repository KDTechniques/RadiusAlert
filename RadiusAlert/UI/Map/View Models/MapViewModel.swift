//
//  MapViewModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import CoreLocation
import SwiftUI
import MapKit

@Observable
final class MapViewModel {
    // MARK: - INJECTED PROPERTIES
    let locationManager: LocationManager
    
    // MARK: - INITIALIZER
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        selectedRadius = mapValues.minimumRadius
    }
    
    // MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    var position: MapCameraPosition = .automatic
    var centerCoordinate: CLLocationCoordinate2D?
    var selectedRadius: CLLocationDistance { didSet { onRadiusChange() } }
    var markerCoordinate: CLLocationCoordinate2D? {
        didSet {
            locationManager.markerCoordinate = markerCoordinate
        }
    }
    var selectedMapStyle: MapStyleTypes = .standard
    var route: MKRoute?
    var isCameraDragging: Bool = false
    var isRadiusSliderActive: Bool = false
    
    // MARK: - FUNCTIONS
    
    // MARK: - Camera Related
    func positionToInitialUserLocation() {
        guard let position: MapCameraPosition = locationManager.getInitialMapCameraPosition() else { return }
        self.position = position
    }
    
    func onContinuousMapCameraChange(_ context: MapCameraUpdateContext) {
        setCameraDragging(true)
        setCenterCoordinate(context.region.center)
    }
    
    func onMapCameraChangeEnd(_ context: MapCameraUpdateContext) {
        setCameraDragging(false)
        setCenterCoordinate(context.region.center)
    }
    
    // MARK: - Validation Related
    func isBeyondMinimumDistance() -> Bool {
        guard let currentLocation = locationManager.currentUserLocation,
              let centerCoordinate else { return false }
        
        let distance: CLLocationDistance = locationManager.getDistance(
            from: centerCoordinate,
            to: currentLocation
        )
        
        return distance > mapValues.minimumDistance
    }
    
    func checkLocationPermissionOnCA() {
        // Check whether the user has still given permission to only when in use and ask them to change it to always ui get triggered here...
        let status: CLAuthorizationStatus = locationManager.manager.authorizationStatus
        if status == .authorizedWhenInUse {
            print("Show a UI to direct user to system settings here...")
        }
    }
    
    func showRadiusCircle() -> Bool {
        let condition1: Bool = isMarkerCoordinateNil() ? isBeyondMinimumDistance() : true
        
        let condition2: Bool = isRadiusSliderActive
        ? true
        : isMarkerCoordinateNil() ? !isCameraDragging : true
        
        return condition1 && condition2
    }
    
    func showMapPin() -> Bool {
        let condition1: Bool = isBeyondMinimumDistance()
        let condition2: Bool = isMarkerCoordinateNil()
        
        return condition1 && condition2
    }
    
    func showRadiusSlider() -> Bool {
        let condition1: Bool = isMarkerCoordinateNil()
        let condition2: Bool = isBeyondMinimumDistance()
        
        return condition1 && condition2
    }
    
    func showFloatingAlertRadiusText() -> Bool {
        let condition1: Bool = showRadiusCircle()
        let condition2: Bool = isMarkerCoordinateNil()
        
        return condition1 && condition2
    }
    
    // MARK: - Radius Related
    func setRadiusCircleCoordinate(_ center: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return isMarkerCoordinateNil() ? center : markerCoordinate!
    }
    
    // MARK: - Marker Related
    func setMarkerCoordinate() {
        guard
            let currentLocation = locationManager.currentUserLocation,
            let centerCoordinate = centerCoordinate else { return }
        
        markerCoordinate = centerCoordinate
        
        let distance: CLLocationDistance = locationManager.getDistance(from: centerCoordinate, to: currentLocation)
        let boundsMeters: CLLocationDistance = distance * mapValues.regionBoundsFactor
        
        position = .region(.init(center: centerCoordinate, latitudinalMeters: boundsMeters, longitudinalMeters: boundsMeters))
    }
    
    func isMarkerCoordinateNil() -> Bool {
        return markerCoordinate == nil
    }
    
    // MARK: - Directions Related
    func getDirections() {
        Task {
            route = await locationManager.getDirections()
        }
    }
    
    func resetDirections() {
        route = nil
    }
    
    // MARK: - Other
    func getRadiusTextString() -> String {
        let intNumber: Int = .init(selectedRadius)
        return "Alert Radius\n" + (intNumber >= 1000 ? String(format: "%.1fkm", selectedRadius/1000) : "\(intNumber)m")
    }
    
    func nextMapStyle() {
        let mapStylesArray: [MapStyleTypes] = MapStyleTypes.allCases
        guard let index: Int = mapStylesArray.firstIndex(where: { $0 == selectedMapStyle }) else { return }
        
        let nextIndex: Int = mapStylesArray.nextIndex(after: index)
        selectedMapStyle = mapStylesArray[nextIndex]
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    // MARK: - Camera Related
    private func setCameraDragging(_ boolean: Bool) {
        isCameraDragging = boolean
    }
    
    // MARK: - Radius Related
    private func setCenterCoordinate(_ center: CLLocationCoordinate2D) {
        centerCoordinate = center
    }
    
    private func onRadiusChange() {
        setRegionBoundsOnRadius()
    }
    
    private func setRegionBoundsOnRadius() {
        guard let centerCoordinate else { return }
        
        let regionBoundMeters: CLLocationDistance = selectedRadius*mapValues.radiusToRegionBoundsMetersFactor
        setRegionBoundMeters(center: centerCoordinate, meters: regionBoundMeters)
    }
    
    // MARK: - Region Bounds Related
    private func setRegionBoundMeters(center: CLLocationCoordinate2D, meters: CLLocationDistance) {
        position = .region(.init(
            center: center,
            latitudinalMeters: meters,
            longitudinalMeters: meters
        ))
    }
}
