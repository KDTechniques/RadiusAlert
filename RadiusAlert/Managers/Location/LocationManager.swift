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
    static let shared: LocationManager = .init()
    let manager: CLLocationManager = .init()
    let alertManager: AlertManager = .shared
    private let errorModel: LocationManagerErrorModel.Type = LocationManagerErrorModel.self
    
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
    @ObservationIgnored var selectedRadius: CLLocationDistance = MapValues.minimumRadius
    @ObservationIgnored var onRegionEntry: (() -> Void) = { }
    @ObservationIgnored private var monitoredRegion: CLCircularRegion?
    @ObservationIgnored var onRegionEntryFailure: (() -> Void) = { }
    
    private let mapValues: MapValues.Type = MapValues.self
    private let regionIdentifier: String = "radiusAlert"
    private(set) var currentDistanceMode: LocationDistanceModes?
    private(set) var currentRegionName: String?
    
    // MARK: - SETTERS
    func setCurrentDistanceMode(_ value: LocationDistanceModes) {
        currentDistanceMode = value
    }
    
    func setCurrentRegionName(_ value: String?) {
        currentRegionName = value
    }
    
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
            
        case .restricted, .denied:
            print("Location service permission is not granted! 😒")
            _ = checkLocationPermission()
            
        case .authorizedWhenInUse:
            print("Location service permission is granted for `When In Use`. 😉")
            manager.requestAlwaysAuthorization()
            
        case .authorizedAlways:
            print("Location service permission is granted for `Always`. 🤗")
            
        default:
            print("Unhandled location service permission context is found! 🤔")
            _ = checkLocationPermission()
        }
    }
    
    /// Called whenever the device gets updated location(s).
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Note: Don't change the following order
        let currentUserLocation: CLLocationCoordinate2D? = locations.last?.coordinate
        updateInitialCurrentRegion(currentUserLocation)
        self.currentUserLocation = currentUserLocation
        
        setLocationAccuracy()
        onRegionEntryFailure()
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
        guard let coordinate: CLLocationCoordinate2D = currentUserLocation else {
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
    
    /// Dynamically adjusts location accuracy and update frequency
    /// based on distance from the marker coordinate.
    func setLocationAccuracy() {
        guard
            let currentUserLocation,
            let markerCoordinate else {
            return
        }
        
        let distanceToRadius: CLLocationDistance = Utilities.getDistanceToRadius(
            userCoordinate: currentUserLocation,
            markerCoordinate: markerCoordinate,
            radius: selectedRadius
        )
        
        let newMode: LocationDistanceModes = LocationDistanceModes.getMode(for: distanceToRadius)
        
        // Only apply if mode actually changed
        guard newMode != currentDistanceMode else { return }
        setCurrentDistanceMode(newMode)
        
        switch newMode {
        case .close:
            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            stopSignificantUpdatesNStartLocationUpdates()
            
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
    
    /// Checks the current location permission before proceeding with manager-level or UI-level actions.
    /// This helps handle edge cases where the map may not function due to denied or restricted permissions,
    /// ensuring a better user experience.
    func checkLocationPermission() -> Bool {
        switch manager.authorizationStatus {
        case .denied, .restricted, .authorizedWhenInUse :
            alertManager.showAlert(.locationPermissionDenied)
            return false
            
        default:
            return true
        }
    }
    
    func getCurrentRegionName(_ currentUserLocation: CLLocationCoordinate2D?) {
        guard let latitude = currentUserLocation?.latitude,
              let longitude = currentUserLocation?.longitude else { return }
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geoCoder = CLGeocoder()
        
        Task {
            do {
                let placemarks: [CLPlacemark] = try await geoCoder.reverseGeocodeLocation(location)
                guard let country: String = placemarks.first?.country else {
                    Utilities.log(errorModel.failedToGetCountry.errorDescription)
                    return
                }
                
                await MainActor.run {
                    self.setCurrentRegionName(country)
                    print("✅: Assigned current region name: \(country.description)")
                }
            } catch let error {
                Utilities.log(errorModel.failedCLGeoCoderOnRegionFilter(error).errorDescription)
            }
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Helper function to stop significant-change updates
    /// and restart normal location updates.
    private func stopSignificantUpdatesNStartLocationUpdates() {
        manager.stopMonitoringSignificantLocationChanges()
        manager.startUpdatingLocation()
    }
    
    private func updateInitialCurrentRegion(_ currentUserLocation: CLLocationCoordinate2D?) {
        guard self.currentUserLocation == nil,
              let currentUserLocation else { return }
        
        getCurrentRegionName(currentUserLocation)
    }
}
