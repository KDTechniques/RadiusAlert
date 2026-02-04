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
        
        for region in manager.monitoredRegions {
            manager.stopMonitoring(for: region)
        }
    }
    
    // MARK: - ASSIGNED PROPERTIES
    var currentUserLocation: CLLocationCoordinate2D? { didSet { currentUserLocation$ = currentUserLocation } }
    @ObservationIgnored @Published private(set) var currentUserLocation$: CLLocationCoordinate2D?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined { didSet { authorizationStatus$ = authorizationStatus } }
    @ObservationIgnored @Published var authorizationStatus$: CLAuthorizationStatus = .notDetermined
    @ObservationIgnored private(set) var regions: Set<RegionModel> = []
    private let mapValues: MapValues.Type = MapValues.self
    private(set) var currentDistanceMode: LocationDistanceModes?
    private(set) var currentRegionName: String?
    
    // MARK: - SETTERS
    func setCurrentDistanceMode(_ value: LocationDistanceModes) {
        currentDistanceMode = value
    }
    
    func setCurrentRegionName(_ value: String?) {
        currentRegionName = value
    }
    
    func insertRegion(_ value: RegionModel) {
        regions.insert(value)
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
    }
    
    /// Triggered when user enters a monitored circular region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("✅ Entered region: ", region.identifier)
        guard let action: () -> Void = regions.first(where: { $0.markerID == region.identifier })?.onRegionEntry else { return }
        action()
    }
    
    /// Called when CoreLocation fails with an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Returns the initial camera position for the map centered on the user’s location
    func getInitialMapCameraPosition() -> MapCameraPosition? {
        guard let currentUserLocation else {
            print("Error getting initial current location of the user!")
            return nil
        }
        
        let regionBoundMeters: CLLocationDistance = mapValues.initialUserLocationBoundsMeters
        let region: MKCoordinateRegion = .init(
            center: currentUserLocation,
            latitudinalMeters: regionBoundMeters,
            longitudinalMeters: regionBoundMeters
        )
        
        return .region(region)
    }
    
    /// Calculates a driving route between two coordinates.
    ///
    /// This async method requests directions from MapKit between the provided
    /// start (`pointA`) and end (`pointB`) coordinates using automobile transport.
    /// It returns the first available `MKRoute` from the response, or `nil` if
    /// the directions request fails or no routes are available.
    ///
    /// - Parameters:
    ///   - coordinate1: The starting coordinate for the route (point A).
    ///   - coordinate2: The destination coordinate for the route (point B).
    /// - Returns: The first `MKRoute` if available; otherwise `nil`.
    /// - Note: This method is `async` and must be awaited. Errors during route
    ///   calculation are caught and logged, and `nil` is returned.
    func getRoute(pointA coordinate1: CLLocationCoordinate2D, pointB coordinate2: CLLocationCoordinate2D) async -> MKRoute? {
        let request: MKDirections.Request = .init()
        request.source = .init(placemark: .init(coordinate: coordinate1))
        request.destination = .init(placemark: .init(coordinate: coordinate2))
        request.transportType = .automobile
        
        do {
            let directions = try await MKDirections(request: request).calculate()
            let route: MKRoute? = directions.routes.first
            return  route
        } catch {
            print("Error getting the route: \(error.localizedDescription)")
            return nil
        }
    }
    
    func startMonitoringRegion(region: RegionModel) -> Bool {
        var region = region
        
        let monitorRegion: CLCircularRegion = .init(center: region.markerCoordinate, radius: region.radius, identifier: region.markerID)
        monitorRegion.notifyOnEntry = true
        monitorRegion.notifyOnExit = false
        
        region.monitor = monitorRegion
        guard let monitor: CLCircularRegion = region.monitor else { return false }
        manager.startMonitoring(for: monitor)
        insertRegion(region)
        
        print("monitored regions count: ", manager.monitoredRegions.count)
        print("monitored regions:\n")
        for monitoredRegion in manager.monitoredRegions {
            print("\(monitoredRegion.description)\n")
        }
        print("Regions count: ", regions.count)
        
        return true
    }
    
    /// Stops monitoring the currently active circular region.
    func stopMonitoringRegion(for region: RegionModel) {
        guard let monitor: CLCircularRegion = region.monitor else { return }
        manager.stopMonitoring(for: monitor)
        regions.remove(region)
    }
    
    func stopMonitoringAllRegions() {
        for region in regions {
            guard let monitor = region.monitor else { return }
            manager.stopMonitoring(for: monitor)
        }
        
        regions.removeAll()
    }
    
    /// Dynamically adjusts location accuracy and update frequency
    /// based on distance from the marker coordinate.
    func setLocationAccuracy() {
        guard let currentUserLocation else { return }
        
        var distances: Set<CLLocationDistance> = []
        for region in regions {
            let distance: CLLocationDistance = Utilities.getDistanceToRadius(
                userCoordinate: currentUserLocation,
                markerCoordinate: region.markerCoordinate,
                radius: region.radius
            )
            
            distances.insert(distance)
        }
        
        guard let minDistance: CLLocationDistance = distances.min() else { return }
        let newMode: LocationDistanceModes = LocationDistanceModes.getMode(for: minDistance)
        
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
            alertManager.showAlert(.locationPermissionDenied(viewLevel: .content))
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
    
    private func removeRegion(for markerID: String) {
        guard let region: RegionModel = regions.first(where: { $0.markerID == markerID }) else { return }
        regions.remove(region)
    }
}
