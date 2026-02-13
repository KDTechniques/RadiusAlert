//
//  MapFloatingCircleView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-02-05.
//

import SwiftUI
import MapKit

struct MapFloatingCircleView: MapContent {
    // MARK: INJECTED PROPERTIES
    let centerCoordinate: CLLocationCoordinate2D?
    let radius: CGFloat
    let condition: Bool
    
    // MARK: - INITIALIZER
    init(centerCoordinate: CLLocationCoordinate2D?, radius: CGFloat, condition: Bool) {
        self.centerCoordinate = centerCoordinate
        self.radius = radius
        self.condition = condition
    }
    
    // MARK: - BODY
    var body: some MapContent {
        if let centerCoordinate, condition {
            MapCircle(center: centerCoordinate, radius: radius)
                .foregroundStyle(.primary.opacity(0.3))
        }
    }
}

// MARK: - PREVIEWS
#Preview("MapFloatingCircleView") {
    Map {
        MapFloatingCircleView(
            centerCoordinate: LocationManager.shared.currentUserLocation,
            radius: MapValues.minimumRadius,
            condition: true
        )
    }
    .previewModifier()
}
