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
        Binding { [weak self] in
            self?.selectedRadius ?? MapValues.minimumRadius
        } set: { newValue in
            withAnimation { [weak self] in
                self?.setSelectedRadius(newValue)
            }
        }
    }
    
    func getRadiusTextString(_ radius: CLLocationDistance, withAlertRadiusText: Bool = true) -> String {
        let intNumber: Int = .init(radius)
        let numberText: String = intNumber >= 1000 ? String(format: "%.1fkm", radius/1000) : "\(intNumber)m"
        
        return withAlertRadiusText ? ("Alert Radius\n"+numberText) : numberText
    }
    
    func setRadiusCircleCoordinate(_ center: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return isMarkerCoordinateNil() ? center : markerCoordinate!
    }
    
    func onRadiusChange() {
        setRegionBoundsOnRadius()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setRegionBoundsOnRadius() {
        guard let centerCoordinate else { return }
        
        let regionBoundMeters: CLLocationDistance = selectedRadius*mapValues.radiusToRegionBoundsMetersFactor
        setRegionBoundMeters(center: centerCoordinate, meters: regionBoundMeters)
    }
}
