//
//  ContentViewModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import CoreLocation
import SwiftUI
import MapKit

final class ContentViewModel: ObservableObject {
    // MARK: - INJECTED PROPERTIES
    let locationManager: LocationManager = .init()
    
    // MARK: - ASSIGNED PROPERTIES
    @Published var searchText: String = ""
    @Published var position: MapCameraPosition = .automatic
    @Published var centerCoordinate: CLLocationCoordinate2D?
    @Published var radius: CLLocationDistance = 500
    
    // MARK: - INITIALIZER
    init() { }
    
    // MARK: - FUNCTIONS
    func positionToInitialUserLocation() {
        guard let position: MapCameraPosition = locationManager.getInitialUserCurrentLocation() else { return }
        self.position = position
    }
}
