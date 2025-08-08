//
//  MapRadius.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import CoreLocation

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    func getRadiusTextString() -> String {
        let intNumber: Int = .init(selectedRadius)
        return "Alert Radius\n" + (intNumber >= 1000 ? String(format: "%.1fkm", selectedRadius/1000) : "\(intNumber)m")
    }
    
    func setCenterCoordinate(_ center: CLLocationCoordinate2D) {
        centerCoordinate = center
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
