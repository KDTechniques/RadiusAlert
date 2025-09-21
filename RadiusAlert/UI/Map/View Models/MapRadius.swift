//
//  MapRadius.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import CoreLocation
import SwiftUI

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func selectedRadiusBinding() -> Binding<CLLocationDistance> {
        return Binding { [weak self] in
            self?.selectedRadius ?? MapValues.minimumRadius
        } set: { newValue in
            withAnimation { [weak self] in
                self?.setSelectedRadius(newValue)
            }
        }
    }
    
    func getRadiusTextString(_ radius: CLLocationDistance, withAlertRadiusText: Bool) -> String {
        let numberText: String = radius >= 1000 ? String(format: "%.1fkm", radius/1000) : "\(Int(radius))m"
        
        let text: String = withAlertRadiusText ? ("Alert Radius\n"+numberText) : numberText
        
        guard withAlertRadiusText, let name: String = selectedSearchResult?.name else { return text }
        let textWithName: String = "(\(name))\n\(text)"
        
        return textWithName
    }
    
    func getRadiusCircleCoordinate() -> CLLocationCoordinate2D? {
        guard let centerCoordinate else { return nil }
        return isMarkerCoordinateNil() ? centerCoordinate : markerCoordinate!
    }
    
    func onRadiusChange(_ radius: CLLocationDistance) {
        setRegionBoundsOnRadius()
        locationManager.selectedRadius = radius
    }
    
    func setRegionBoundsOnRadius() {
        guard let centerCoordinate else { return }
        
        let regionBoundMeters: CLLocationDistance = selectedRadius*mapValues.radiusToRegionBoundsMetersFactor
        setRegionBoundMeters(center: centerCoordinate, meters: regionBoundMeters)
    }
    
    func handleOnRegionEntryAlertFailure() {
        guard
            locationManager.currentDistanceMode == .close,
            let markerCoordinate,
            let userLocation: CLLocationCoordinate2D = locationManager.currentUserLocation else { return }
        
        let distance: CLLocationDistance = Utilities.getDistance(from: userLocation, to: markerCoordinate)
        guard distance < selectedRadius else { return }
        
        onRegionEntry()
    }
}
