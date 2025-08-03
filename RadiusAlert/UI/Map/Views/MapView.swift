//
//  MapView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import MapKit

struct MapView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    @Environment(ContentViewModel.self) private var contentVM
    
    // MARK: - ASSIGNED PROPERTIERS
    @Namespace var mapSpace
    
    // MARK: - BODY
    var body: some View {
        @Bindable var mapVM: MapViewModel = mapVM
        Map(position: $mapVM.position) {
            UserAnnotation()
            
            if let centerCoordinate = mapVM.centerCoordinate,
               mapVM.showRadiusCircle {
                MapCircle(center: centerCoordinate, radius: mapVM.selectedRadius)
                    .foregroundStyle(.pink.gradient.opacity(0.5))
            }
            
            if let markerCoordinate = mapVM.markerCoordinate {
                Marker("Stop", coordinate: markerCoordinate)
            }
            
            if let route = mapVM.route {
                MapPolyline(route)
                    .stroke(Color.pink.gradient, lineWidth: 3)
            }
        }
        .mapStyle(mapVM.selectedMapStyle.mapStyle)
        .mapControls {
            MapUserLocationButton(scope: mapSpace)
            MapPitchToggle(scope: mapSpace)
            MapCompass(scope: mapSpace)
            MapScaleView(scope: mapSpace)
        }
        .onMapCameraChange(frequency: .continuous) {
            mapVM.onContinuousMapCameraChange($0)
        }
        .onMapCameraChange(frequency: .onEnd) {
            mapVM.onMapCameraChangeEnd($0)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Map View") {
    MapView()
        .previewModifier()
}
