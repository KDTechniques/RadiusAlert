//
//  CLCoordinate2D + EXT.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-11.
//

import CoreLocation

extension CLLocationCoordinate2D {
    /// Checks equality within a certain decimal precision
    func isEqual(to other: CLLocationCoordinate2D, precision: Int = 6) -> Bool {
        let a = self.rounded(to: precision)
        let b = other.rounded(to: precision)
        return a.latitude == b.latitude && a.longitude == b.longitude
    }
    
    /// Rounds latitude and longitude to given decimal places for safe comparison
    private func rounded(to places: Int) -> CLLocationCoordinate2D {
        let factor = pow(10.0, Double(places))
        return CLLocationCoordinate2D(
            latitude: (latitude * factor).rounded() / factor,
            longitude: (longitude * factor).rounded() / factor
        )
    }
}
