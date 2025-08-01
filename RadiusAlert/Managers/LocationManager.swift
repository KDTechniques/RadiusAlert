//
//  CustomLocationManager.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

@Observable
final class LocationManager: NSObject, CLLocationManagerDelegate {
    // MARK: - ASSIGNED PROPERTIES
    let manager: CLLocationManager = .init()
    var shouldStopLocationUpdates: Bool = false
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        manager.delegate = self
    }
    
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
    
    func getInitialUserCurrentLocation() -> MapCameraPosition? {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else {
            print("Error getting initial user's current location!")
            return nil
        }
        
        let distance: CLLocationDistance = 1000
        let region: MKCoordinateRegion = .init(center: coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        
        return .region(region)
    }
    
    func getDistance(from location1: CLLocation, to location2: CLLocation) -> CLLocationDistance {
        return location1.distance(from: location2)
    }
}
