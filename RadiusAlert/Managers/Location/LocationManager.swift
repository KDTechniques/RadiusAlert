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
        updateDidEnterRegion(for: region.identifier)
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
        
        let regionBoundMeters: CLLocationDistance = MapValues.initialUserLocationBoundsMeters
        let region: MKCoordinateRegion = .init(
            center: currentUserLocation,
            latitudinalMeters: regionBoundMeters,
            longitudinalMeters: regionBoundMeters
        )
        
        return .region(region)
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
        
        return true
    }
    
    func stopNUpdateMonitorRegion(markerID: String, newRadius: CLLocationDistance) -> Bool {
        guard let currentRegion: RegionModel = regions.first(where: { $0.markerID == markerID }) else { return false }
        
        stopMonitoringRegion(for: currentRegion)
        
        let newRegion: RegionModel = .init(
            markerCoordinate: currentRegion.markerCoordinate,
            radius: newRadius,
            onRegionEntry: currentRegion.onRegionEntry
        )
        
        guard startMonitoringRegion(region: newRegion) else { return false }
        
        return true
    }
    
    /// Stops monitoring the currently active circular region.
    func stopMonitoringRegion(for region: RegionModel) {
        guard let monitor: CLCircularRegion = region.monitor else { return }
        manager.stopMonitoring(for: monitor)
        regions.remove(region)
    }
    
    /// Dynamically adjusts location accuracy and update frequency
    /// based on distance from the marker coordinate.
    func setLocationAccuracy() {
        guard !regions.isEmpty,
              let minDistance: CLLocationDistance = getMinDistance() else { return }
        
        let newMode = LocationDistanceModes.getMode(for: minDistance)
        
        // TRACKING vs IDLE MODE (IMPORTANT)
        let trackingThreshold: CLLocationDistance = 15000 // 15km
        changeLocationUpdatesOnMinDistance(minDistance: minDistance, trackingThreshold: trackingThreshold)
        
        // Don’t fully block updates on same mode (important for highways)
        newMode != currentDistanceMode ? setCurrentDistanceMode(newMode) : ()
        
        // Apply settings (always, not only when mode changes)
        switch newMode {
        case .close: // < 1km
            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            manager.distanceFilter = 5
            
        case .medium: // 1–3km
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.distanceFilter = 20
            
        case .far: // 3–10km
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.distanceFilter = 50
            
        case .veryFar: // > 10km
            manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            manager.distanceFilter = 100
        }
        
        // SPEED OVERRIDE (highway fix)
        if let speed = manager.location?.speed, speed > 20 { // ~72 km/h
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.distanceFilter = 20
        }
        
        // Safety cap
        if manager.distanceFilter > 100 {
            manager.distanceFilter = 100
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
                    Utilities.log(LocationManagerErrorModel.failedToGetCountry.errorDescription)
                    return
                }
                
                await MainActor.run {
                    setCurrentRegionName(country)
                    print("✅: Assigned current region name: \(country.description)")
                }
            } catch let error {
                Utilities.log(LocationManagerErrorModel.failedCLGeoCoderOnRegionFilter(error).errorDescription)
            }
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func getMinDistance() -> CLLocationDistance? {
        guard let currentUserLocation else { return .greatestFiniteMagnitude }
        
        let minDistance: CLLocationDistance? = regions.compactMap { region in
            Utilities.getDistanceToRadius(
                userCoordinate: currentUserLocation,
                markerCoordinate: region.markerCoordinate,
                radius: region.radius
            )
        }.min()
        
        return minDistance
    }
    
    private func changeLocationUpdatesOnMinDistance(minDistance: CLLocationDistance, trackingThreshold: CLLocationDistance) {
        if minDistance <= trackingThreshold {
            if manager.monitoredRegions.count > 0 || manager.location != nil {
                manager.stopMonitoringSignificantLocationChanges()
                manager.startUpdatingLocation()
            }
        } else {
            manager.stopUpdatingLocation()
            manager.startMonitoringSignificantLocationChanges()
        }
    }
    
    private func updateInitialCurrentRegion(_ currentUserLocation: CLLocationCoordinate2D?) {
        guard self.currentUserLocation.isNil(),
              let currentUserLocation else { return }
        
        getCurrentRegionName(currentUserLocation)
    }
    
    private func removeRegion(for markerID: String) {
        guard let region: RegionModel = regions.first(where: { $0.markerID == markerID }) else { return }
        regions.remove(region)
    }
    
    private func updateDidEnterRegion(for identifier: String) {
        guard var region: RegionModel = regions.first(where: { $0.markerID == identifier }) else { return }
        region.didEnterRegion = true
        regions.update(with: region)
    }
}
