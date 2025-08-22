//
//  CustomLocationManager.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import CoreLocation
import SwiftUI
import MapKit

@Observable
final class LocationManager: NSObject, CLLocationManagerDelegate {
    // MARK: - ASSIGNED PROPERTIES
    let manager: CLLocationManager = .init()
    static let shared: LocationManager = .init()
    
    // MARK: - INITIALIZER
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.startUpdatingLocation()
    }
    
    // MARK: - ASSIGNED PROPERTIES
    var currentUserLocation: CLLocationCoordinate2D?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined { didSet { authorizationStatus$ = authorizationStatus } }
    @ObservationIgnored @Published var authorizationStatus$: CLAuthorizationStatus = .notDetermined
    @ObservationIgnored var markerCoordinate: CLLocationCoordinate2D?
    @ObservationIgnored var onRegionEntry: (() -> Void) = { }
    
    private let mapValues: MapValues.Type = MapValues.self
    private let regionIdentifier: String = "radiusAlert"
    @ObservationIgnored private var monitoredRegion: CLCircularRegion?
    @ObservationIgnored private var currentMode: LocationDistanceModes?
    
    // MARK: - DELEGATE FUNCTIONS
    
    /// Called whenever the app’s location authorization changes.
    /// Handles prompting the user for appropriate permissions.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // First, request permission for `WhenInUseAuthorization` when: .notDetermined
        // Secondly, request permission for `AlwaysAuthorization` when: .authorizedWhenInUse
        // Update location when: .authorizedAlways, .authorizedWhenInUse
        // Direct user to iPhone Settings when: .restricted, .denied
        authorizationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Location service permission is not determined! 🤷🏻‍♂️")
            manager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            print("Location service permission is not granted! 😒")
            AlertManager.shared.alertItem = AlertTypes.locationPermissionDenied
            break
        case .authorizedWhenInUse:
            print("Location service permission is granted for `When In Use`. 😉")
            manager.requestAlwaysAuthorization()
            break
            
        case .authorizedAlways:
            print("Location service permission is granted for `Always`. 🤗")
            break
        default:
            print("Unhandled location service permission context is found! 🤔")
            AlertManager.shared.alertItem = AlertTypes.locationPermissionDenied
            break
        }
    }
    
    /// Called whenever the device gets updated location(s).
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentUserLocation = locations.first?.coordinate
        setLocationAccuracy()
    }
    
    /// Triggered when user enters a monitored circular region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard region.identifier == monitoredRegion?.identifier else { return }
        print("✅ Entered region: \(region.identifier)")
        onRegionEntry()
    }
    
    /// Called when CoreLocation fails with an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Returns the initial camera position for the map centered on the user’s location
    func getInitialMapCameraPosition() -> MapCameraPosition? {
        guard let coordinate: CLLocationCoordinate2D =  currentUserLocation else {
            print("Error getting initial current location of the user!")
            return nil
        }
        
        let regionBoundMeters: CLLocationDistance = mapValues.initialUserLocationBoundsMeters
        let region: MKCoordinateRegion = .init(
            center: coordinate,
            latitudinalMeters: regionBoundMeters,
            longitudinalMeters: regionBoundMeters
        )
        
        return .region(region)
    }
    
    /// Fetches driving route from user’s location to the marker destination
    func getRoute() async -> MKRoute? {
        guard
            let currentUserLocation,
            let markerCoordinate else { return nil }
        
        let request: MKDirections.Request = .init()
        request.source = .init(placemark: .init(coordinate: currentUserLocation))
        request.destination = .init(placemark: .init(coordinate: markerCoordinate))
        request.transportType = .automobile
        
        do {
            let directions = try await MKDirections(request: request).calculate()
            let route: MKRoute? = directions.routes.first
            return  route
        } catch {
            print("Error getting directions: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Starts monitoring a circular region around the marker coordinate.
    /// Returns `false` if marker coordinate is not set.
    func startMonitoringRegion(radius: Double) -> Bool {
        // Stop monitoring old region if any
        if let oldRegion = monitoredRegion {
            manager.stopMonitoring(for: oldRegion)
        }
        
        guard let markerCoordinate else {
            return false
        }
        
        let region = CLCircularRegion(center: markerCoordinate, radius: radius, identifier: regionIdentifier)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        monitoredRegion = region
        manager.startMonitoring(for: region)
        return true
    }
    
    /// Stops monitoring the currently active circular region.
    func stopMonitoringRegion() {
        guard let monitoredRegion else { return }
        
        manager.stopMonitoring(for: monitoredRegion)
        self.monitoredRegion = nil
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Dynamically adjusts location accuracy and update frequency
    /// based on distance from the marker coordinate.
    private func setLocationAccuracy() {
        guard
            let currentUserLocation,
            let markerCoordinate else {
            return
        }
        
        let distance: CLLocationDistance = Utilities.getDistance(from: currentUserLocation, to: markerCoordinate)
        
        let newMode: LocationDistanceModes
        
        switch distance {
        case ..<1_000:
            newMode = .close
        case 1_000..<3_000:
            newMode = .medium
        case 3_000..<10_000:
            newMode = .far
        default:
            newMode = .veryFar
        }
        
        // Only apply if mode actually changed
        guard newMode != currentMode else { return }
        currentMode = newMode
        
        switch newMode {
        case .close:
            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            
        case .medium:
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.distanceFilter = 100
            stopSignificantUpdatesNStartLocationUpdates()
            
        case .far:
            manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            manager.distanceFilter = 500
            stopSignificantUpdatesNStartLocationUpdates()
            
        case .veryFar:
            manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            manager.stopUpdatingLocation()
            manager.startMonitoringSignificantLocationChanges()
        }
    }
    
    /// Helper function to stop significant-change updates
    /// and restart normal location updates.
    private func stopSignificantUpdatesNStartLocationUpdates() {
        manager.stopMonitoringSignificantLocationChanges()
        manager.startUpdatingLocation()
    }
    
}





