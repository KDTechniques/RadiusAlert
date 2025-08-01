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
        Map(position: .constant(.automatic)) {
            UserAnnotation()
            
            if let centerCoordinate = mapVM.centerCoordinate {
                MapCircle(center: centerCoordinate, radius: mapVM.radius)
                    .foregroundStyle(.red.opacity(0.5))
                    .stroke(.secondary, style: .init(lineWidth: 2))
            }
        }
        .mapControls {
            MapUserLocationButton(scope: mapSpace)
            MapPitchToggle(scope: mapSpace)
        }
        .onMapCameraChange(frequency: .continuous) {
            mapVM.onContinuousMapCameraChange()
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
