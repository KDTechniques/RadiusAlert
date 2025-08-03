//
//  MapValues.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-02.
//

import CoreLocation

struct MapValues {
    static let regionBoundsFactor: CLLocationDistance = 1.8
    static let minimumDistance: CLLocationDistance = 1000
    
    static let minimumRadius: CLLocationDistance = 700
    static var minimumRadiusString: String { "\(Int(self.minimumRadius))m" }
    
    static let maximumRadius:  CLLocationDistance = 3000
    static var maximumRadiusString: String { "\(Int(self.maximumRadius/1000))km" }
    
    static let radiusSliderWidthFactor: CGFloat = 1.7
}
