//
//  MapMarkerCirclesView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-02-05.
//

import SwiftUI
import MapKit

struct MapMarkerCirclesView: MapContent {
    // MARK: - INJECTED PROPERTIES
    let markers: [MarkerModel]
    
    // MARK: - INITIALIZER
    init(markers: [MarkerModel]) {
        self.markers = markers
    }
    
    // MARK: - BODY
    var body: some MapContent {
        ForEach(markers) { marker in
            MapCircle(center: marker.coordinate, radius: marker.radius)
                .foregroundStyle(marker.color.opacity(0.3))
        }
    }
}

// MARK: - PREVIEWS
#Preview("MapMarkerCirclesView") {
    Map {
        MapMarkerCirclesView(markers: [
            .init(
                title: nil,
                coordinate: LocationManager.shared.currentUserLocation!,
                radius: MapValues.minimumRadius,
                color: .debug,
                number: .zero
            )
        ])
    }
    .previewModifier()
}
