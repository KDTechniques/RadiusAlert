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
    var showRadiusCircle: Bool = false {
        didSet {
            print("💜💜💜💜💜: \(showRadiusCircle)")
        }
    }
    var markerCoordinate: CLLocationCoordinate2D? {
        didSet {
            locationManager.markerCoordinate = markerCoordinate
            setRadiusCircleVisibilityOnMarkerCoordinate()
        }
    }
    var selectedMapStyle: MapStyleTypes = .standard
    var route: MKRoute?
    
    // MARK: - FUNCTIONS
    func positionToInitialUserLocation() {
        guard let position: MapCameraPosition = locationManager.getInitialMapCameraPosition() else { return }
        self.position = position
    }
    
    func onContinuousMapCameraChange(_ context: MapCameraUpdateContext) {
        setCenterRegionCoordinate(context.region.center)
        radiusCircleVisibilityHandler(false)
    }
    
    func onMapCameraChangeEnd(_ context: MapCameraUpdateContext) {
        setCenterRegionCoordinate(context.region.center)
        radiusCircleVisibilityHandler()
        
        // Check whether the user has still given permission to only when in use and ask them to change it to always ui get triggered here...
        let status: CLAuthorizationStatus = locationManager.manager.authorizationStatus
        if status == .authorizedWhenInUse {
            print("Show a UI to direct user to system settings here...")
        }
    }
    
    func radiusTextHandler() -> String {
        let intNumber: Int = .init(selectedRadius)
        return intNumber >= 1000 ? String(format: "%.1fkm", selectedRadius/1000) : "\(intNumber)m"
    }
    
    func isBeyondMinimumDistance() -> Bool {
        guard let currentLocation = locationManager.currentUserLocation,
              let centerCoordinate else { return false }
        
        let distance: CLLocationDistance = locationManager.getDistance(from: centerCoordinate, to: currentLocation)
        return distance > mapValues.minimumDistance
    }
    
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
    
    func setRadiusCircleVisibilityOnMarkerCoordinate() {
        //        radiusCircleVisibilityHandler(markerCoordinate != nil)
        let isNil: Bool = markerCoordinate == nil
        
        showRadiusCircle = !isNil
    }
    
    func nextMapStyle() {
        let mapStylesArray: [MapStyleTypes] = MapStyleTypes.allCases
        guard let index: Int = mapStylesArray.firstIndex(where: { $0 == selectedMapStyle }) else { return }
        
        let nextIndex: Int = mapStylesArray.nextIndex(after: index)
        selectedMapStyle = mapStylesArray[nextIndex]
    }
    
    func getDirections() {
        Task {
            route = await locationManager.getDirections()
        }
    }
    
    func resetDirections() {
        route = nil
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setCenterRegionCoordinate(_ center: CLLocationCoordinate2D) {
        centerCoordinate = center
    }
    
    private func radiusCircleVisibilityHandler(_ boolean: Bool? = nil) {
        if let boolean {
            showRadiusCircle = boolean
        } else {
            showRadiusCircle = isBeyondMinimumDistance()
        }
    }
    
    private func onRadiusChange() {
        print(selectedRadius)
    }
}
