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
    var radius: CLLocationDistance = 500
    
    // MARK: - INITIALIZER
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    
    // MARK: - FUNCTIONS
    func positionToInitialUserLocation() {
        guard let position: MapCameraPosition = locationManager.getInitialUserCurrentLocation() else { return }
        self.position = position
    }
}
