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
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    @Environment(ContentViewModel.self) private var contentVM
    
    // MARK: - ASSIGNED PROPERTIERS
    @Namespace var mapSpace
    
    // MARK: - BODY
    var body: some View {
        @Bindable var mapVM: MapViewModel = mapVM
        
        Map(position: $mapVM.position) {
            // User's Current Location
            UserAnnotation()
            
            // Radius Circle
            if let centerCoordinate = mapVM.centerCoordinate, mapVM.showRadiusCircle() {
                MapCircle(
                    center: mapVM.setRadiusCircleCoordinate(centerCoordinate),
                    radius: mapVM.selectedRadius
                )
                .foregroundStyle((colorScheme == .dark ? Color.white : Color.black).opacity(0.3))
            }
            
            // Marker
            if let markerCoordinate = mapVM.markerCoordinate {
                Marker(mapVM.getRadiusTextString(), coordinate: markerCoordinate)
            }
            
            // Route
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
        .onMapCameraChange(frequency: .continuous) { mapVM.onContinuousMapCameraChange($0) }
        .onMapCameraChange(frequency: .onEnd) { mapVM.onMapCameraChangeEnd($0) }
    }
}

// MARK: - PREVIEWS
#Preview("Map View") {
    MapView()
        .previewModifier()
}
