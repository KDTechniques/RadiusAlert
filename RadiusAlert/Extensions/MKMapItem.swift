//
//  MKMapItem.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-29.
//

import MapKit

extension MKMapItem {
    /// The geographic coordinate of this map item.
    ///
    /// Handles the API difference introduced in iOS 26:
    /// - On iOS 26 and later, uses the `location` property on `MKMapItem`.
    /// - On earlier iOS versions, falls back to the coordinate of the item's `placemark`.
    ///
    /// Usage:
    /// ```swift
    /// let coord = mapItem.coordinate
    /// ```
    var coordinate: CLLocationCoordinate2D {
        if #available(iOS 26.0, *) {
            return self.location.coordinate
        } else {
            return self.placemark.coordinate
        }
    }
}
