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
        
        let text: String = withAlertRadiusText ? ("Alert Radius\n"+numberText) : numberText
        
        guard let name: String = selectedSearchResult?.name else { return text }
        let textWithName: String = "(\(name))\n\(text)"
        
        return textWithName
    }
    
    func getRadiusCircleCoordinate() -> CLLocationCoordinate2D? {
        guard let centerCoordinate else { return nil }
        return isMarkerCoordinateNil() ? centerCoordinate : markerCoordinate!
    }
    
    func onRadiusChange() {
        setRegionBoundsOnRadius()
    }
    
    func setRegionBoundsOnRadius() {
        guard let centerCoordinate else { return }
        
        let regionBoundMeters: CLLocationDistance = selectedRadius*mapValues.radiusToRegionBoundsMetersFactor
        setRegionBoundMeters(center: centerCoordinate, meters: regionBoundMeters)
    }
}
