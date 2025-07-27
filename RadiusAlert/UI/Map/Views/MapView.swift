//
//  MapView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        Map(position: $position) {
            UserAnnotation()
            
            if let centerCoordinate {
                MapCircle(center: centerCoordinate, radius: radius)
                    .foregroundStyle(.red.opacity(0.5))
                    .stroke(.secondary, style: .init(lineWidth: 2))
            }
        }
        .mapControls {
            MapUserLocationButton(scope: mapSpace)
            MapPitchToggle(scope: mapSpace)
        }
        .onMapCameraChange(frequency: .continuous) {
            centerCoordinate = nil
        }
        .onMapCameraChange(frequency: .onEnd) {
            centerCoordinate = $0.region.center
            
            // Check whether the user has still given permission to only when in use and ask them to change it to always ui get triggered here...
            let status: CLAuthorizationStatus = locationManager.manager.authorizationStatus
            if status == .authorizedWhenInUse {
                print("Show a UI to direct user to system settings here...")
            }
        }
    }
}

#Preview {
    MapView()
}
