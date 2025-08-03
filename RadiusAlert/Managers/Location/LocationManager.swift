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
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.startUpdatingLocation()
    }
    
    // MARK: - ASSIGNED PROPERTIES
    let locationManagerValues: LocationManagerValues.Type = LocationManagerValues.self
    var currentLocation: CLLocationCoordinate2D?
    
    // MARK: - DELEGATE FUNCTIONS
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // First, request permission for `WhenInUseAuthorization` when: .notDetermined
        // Secondly, request permission for `AlwaysAuthorization` when: .authorizedWhenInUse
        // Update location when: .authorizedAlways, .authorizedWhenInUse
        // Direct user to iPhone Settings when: .restricted, .denied
        
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Location service permission is not determined! 🤷🏻‍♂️")
            manager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            print("Location service permission is not granted! 😒")
            // Show an UI to direct user to system settings here...
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
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
    
    // MARK: - DEFINED FUNCTIONS
    func getInitialMapCameraPosition() -> MapCameraPosition? {
        guard let coordinate: CLLocationCoordinate2D =  currentLocation else {
            print("Error getting initial current location of the user!")
            return nil
        }
        
        let regionBoundMeters: CLLocationDistance = locationManagerValues.initialUserLocationBoundsMeters
        let region: MKCoordinateRegion = .init(
            center: coordinate,
            latitudinalMeters: regionBoundMeters,
            longitudinalMeters: regionBoundMeters
        )
        
        return .region(region)
    }
    
    func getDistance(from location1: CLLocationCoordinate2D, to location2: CLLocationCoordinate2D) -> CLLocationDistance {
        let location1: CLLocation = .init(latitude: location1.latitude, longitude: location1.longitude)
        let location2: CLLocation = .init(latitude: location2.latitude, longitude: location2.longitude)
        return location1.distance(from: location2)
    }
    
    
}
