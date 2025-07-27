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
    @EnvironmentObject private var contentVM: ContentViewModel
    
    // MARK: - ASSIGNED PROPERTIERS
    @Namespace var mapSpace
    
    // MARK: - BODY
    var body: some View {
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
            contentVM.centerCoordinate = nil
        }
        .onMapCameraChange(frequency: .onEnd) {
            contentVM.centerCoordinate = $0.region.center
            
            // Check whether the user has still given permission to only when in use and ask them to change it to always ui get triggered here...
            let status: CLAuthorizationStatus = contentVM.locationManager.manager.authorizationStatus
            if status == .authorizedWhenInUse {
                print("Show a UI to direct user to system settings here...")
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Map View") {
    MapView()
        .previewModifier()
}
