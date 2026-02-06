//
//  MapRoutesView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-02-06.
//

import SwiftUI
import MapKit

struct MapRoutesView: MapContent {
    // MARK: - INJECTED PROPERTIES
    let markers: [MarkerModel]
    
    // MARK: - INITIALIZER
    init(markers: [MarkerModel]) {
        self.markers = markers
    }
    
    // MARK: - BODY
    var body: some MapContent {
        ForEach(markers) { marker in
            if let route: MKRoute = marker.route {
                MapPolyline(route)
                    .stroke(marker.color, lineWidth: 3)
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("MapRoutesView") {
    Map {
        MapRoutesView(markers: MarkerModel.mock)
    }
    .previewModifier()
}
