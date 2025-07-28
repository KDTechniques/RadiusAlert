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
    @Environment(ContentViewModel.self) private var contentVM
    
    // MARK: - ASSIGNED PROPERTIERS
    @Namespace var mapSpace
    
    // MARK: - BODY
    var body: some View {
        @Bindable var contentVM: ContentViewModel = contentVM
        Map(position: $contentVM.position) {
            UserAnnotation()
            
            if let centerCoordinate = contentVM.centerCoordinate {
                MapCircle(center: centerCoordinate, radius: contentVM.radius)
                    .foregroundStyle(.red.opacity(0.5))
                    .stroke(.secondary, style: .init(lineWidth: 2))
            }
        }
        .mapControls {
            MapUserLocationButton(scope: mapSpace)
            MapPitchToggle(scope: mapSpace)
        }
        .onMapCameraChange(frequency: .continuous) {
            contentVM.onContinuousMapCameraChange()
        }
        .onMapCameraChange(frequency: .onEnd) {
            contentVM.onMapCameraChangeEnd($0)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Map View") {
    MapView()
        .previewModifier()
}
