//
//  ContentViewModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import CoreLocation
import SwiftUI
import MapKit

@Observable
final class ContentViewModel {
    // MARK: - INJECTED PROPERTIES
    let locationManager: LocationManager
    
    // MARK: - ASSIGNED PROPERTIES
    var searchText: String = ""
    var position: MapCameraPosition = .automatic
    var centerCoordinate: CLLocationCoordinate2D?
    var radius: CLLocationDistance = 700
    
    // MARK: - INITIALIZER
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    
    // MARK: - FUNCTIONS
    func positionToInitialUserLocation() {
        guard let position: MapCameraPosition = locationManager.getInitialUserCurrentLocation() else { return }
        self.position = position
    }
    
    func onContinuousMapCameraChange() {
        centerCoordinate = nil
    }
    
    func onMapCameraChangeEnd(_ context: MapCameraUpdateContext) {
//        centerCoordinate = context.camera.centerCoordinate
        
        // Check whether the user has still given permission to only when in use and ask them to change it to always ui get triggered here...
        let status: CLAuthorizationStatus = locationManager.manager.authorizationStatus
        if status == .authorizedWhenInUse {
            print("Show a UI to direct user to system settings here...")
        }
    }
    
    func radiusTextHandler() -> String {
        let intNumber: Int = .init(radius)
        return intNumber >= 1000 ? String(format: "%.1fkm", radius/1000) : "\(intNumber)m"
    }
}
