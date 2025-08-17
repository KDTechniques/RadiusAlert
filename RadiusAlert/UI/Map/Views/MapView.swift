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
    
    // MARK: - ASSIGNED PROPERTIERS
    @Namespace var mapSpace
    
    // MARK: - BODY
    var body: some View {
        @Bindable var mapVM: MapViewModel = mapVM
//        let _ = Self._printChanges()
        
        Map(position: mapVM.positionBinding(), interactionModes: mapVM.interactionModes) {
            // User's Current Location
            UserAnnotation()
            
            // Radius Circle
            if let centerCoordinate: CLLocationCoordinate2D = mapVM.getRadiusCircleCoordinate(),
               mapVM.showRadiusCircle() {
                MapCircle(
                    center: centerCoordinate,
                    radius: mapVM.selectedRadius
                )
                .foregroundStyle(Color.getNotPrimary(colorScheme: colorScheme).opacity(0.3))
            }
            
            // Marker
            if let markerCoordinate = mapVM.markerCoordinate {
                Marker(mapVM.getRadiusTextString(mapVM.selectedRadius), coordinate: markerCoordinate)
            }
            
            // Route
            if let route = mapVM.route {
                MapPolyline(route)
                    .stroke(Color.pink.gradient, lineWidth: 3)
            }
        }
        .mapStyle(mapVM.selectedMapStyle.mapStyle)
        .mapControls { mapControls }
        .mapControlVisibility(mapVM.isMarkerCoordinateNil() ? .visible : .hidden)
        .onMapCameraChange(frequency: .continuous) { mapVM.onContinuousMapCameraChange($0) }
        .onMapCameraChange(frequency: .onEnd) { mapVM.onMapCameraChangeEnd($0) }
    }
}

// MARK: - PREVIEWS
#Preview("Map") {
    ContentView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension MapView {
    @ViewBuilder
    private var mapControls: some View {
        MapUserLocationButton(scope: mapSpace)
        MapPitchToggle(scope: mapSpace)
        MapCompass(scope: mapSpace)
        MapScaleView(scope: mapSpace)
    }
}
