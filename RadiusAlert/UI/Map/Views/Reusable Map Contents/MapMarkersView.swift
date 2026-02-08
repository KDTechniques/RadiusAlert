//
//  MapMarkersView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-02-05.
//

import SwiftUI
import MapKit

struct MapMarkersView: MapContent {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    let markers: [MarkerModel]
    
    // MARK: - INITIALIZER
    init(markers: [MarkerModel]) {
        self.markers = markers
    }
    
    // MARK: - BODY
    var body: some MapContent {
        ForEach(markers) { marker in
            let radiusText: String = mapVM.getRadiusTextString(marker.radius, title: marker.title, withAlertRadiusText: true)
            Group {
                if markers.count == 1 {
                    Marker(radiusText, systemImage: "bell.and.waves.left.and.right.fill", coordinate: marker.coordinate)
                } else {
                    Marker(radiusText, monogram: Text("\(marker.number)"), coordinate: marker.coordinate)
                }
            }
            .tint(marker.color.gradient)
        }
    }
}

// MARK: - PREVIEWS
#Preview("MapMarkersView") {
    Map {
        MapMarkersView(markers: MarkerModel.mock)
    }
    .previewModifier()
}
