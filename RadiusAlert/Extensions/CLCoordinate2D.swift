//
//  CLCoordinate2D.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-11.
//

import CoreLocation

extension CLLocationCoordinate2D {
    /// Compares two coordinates for equality within a specified decimal precision.
    ///
    /// - Parameters:
    ///   - other: The coordinate to compare against.
    ///   - precision: The number of decimal places to consider when comparing. Defaults to `6`.
    /// - Returns: `true` if both latitude and longitude are equal within the given precision, otherwise `false`.
    ///
    /// Example:
    /// ```swift
    /// let a = CLLocationCoordinate2D(latitude: 7.1234567, longitude: 80.1234567)
    /// let b = CLLocationCoordinate2D(latitude: 7.1234568, longitude: 80.1234568)
    /// a.isEqual(to: b, precision: 6) // true
    /// ```
    func isEqual(to other: CLLocationCoordinate2D, precision: Int = 6) -> Bool {
        let a = self.rounded(to: precision)
        let b = other.rounded(to: precision)
        return a.latitude == b.latitude && a.longitude == b.longitude
    }
    
    func markerID() -> String {
        let lat = String(format: "%.6f", self.latitude)
        let lon = String(format: "%.6f", self.longitude)
        
        return "\(lat)_\(lon)"
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Rounds the coordinate's latitude and longitude to the specified number of decimal places.
    ///
    /// - Parameter places: The number of decimal places to round to.
    /// - Returns: A new `CLLocationCoordinate2D` with rounded latitude and longitude values.
    private func rounded(to places: Int) -> CLLocationCoordinate2D {
        let factor = pow(10.0, Double(places))
        return CLLocationCoordinate2D(
            latitude: (latitude * factor).rounded() / factor,
            longitude: (longitude * factor).rounded() / factor
        )
    }
}
