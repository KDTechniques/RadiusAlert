//
//  MapValues.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-02.
//

import CoreLocation
import SwiftUI

struct MapValues {
    // MARK: - Map Related
    static let initialUserLocationBoundsMeters: CLLocationDistance = 2000
    static let regionBoundsFactor: CLLocationDistance = 1.8
    static let minimumDistance: CLLocationDistance = 1000
    static let regionBoundsCenterDelayDuration: Double = 2.0
    
    // MARK: - Radius Related
    static let radiusStep: Double = 100
    static let minimumRadius: CLLocationDistance = 700
    static var minimumRadiusString: String { "\(Int(self.minimumRadius))m" }
    static let maximumRadius:  CLLocationDistance = 3000
    static var maximumRadiusString: String { "\(Int(self.maximumRadius/1000))km" }
    static let radiusSliderWidthFactor: CGFloat = 2
    static let radiusToRegionBoundsMetersFactor: Double = 5
    
    // MARK: - Safe Area Related
    static func safeAreaBackgroundColor(_ colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? .init(uiColor: .systemGray4) : .white
    }
}
