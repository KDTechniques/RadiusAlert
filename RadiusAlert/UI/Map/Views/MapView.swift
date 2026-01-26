//
//  MapView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - ASSIGNED PROPERTIERS
    @Namespace var mapSpace
    
    // MARK: - BODY
    var body: some View {
#if DEBUG
        //        let _ = Self._printChanges()
#endif
        
        Map(position: mapVM.primaryPositionBinding(), interactionModes: mapVM.interactionModes, scope: mapSpace) {
            // MARK: - User's Current Location
            UserAnnotation()
            
            // MARK: - Radius Circles
            
            // MARK:  Floating Circle
            if let centerCoordinate: CLLocationCoordinate2D = mapVM.primaryCenterCoordinate {
                MapCircle(center: centerCoordinate, radius: mapVM.primarySelectedRadius)
                    .foregroundStyle(.primary.opacity(0.3))
            }
            
            // MARK: Marker Circles
            ForEach(mapVM.markers) { marker in
                MapCircle(center: marker.coordinate, radius: marker.radius)
                    .foregroundStyle(marker.color.opacity(0.3))
            }
            
            // MARK: - Markers
            ForEach(mapVM.markers) { marker in
                let radiusText: String = mapVM.getRadiusTextString(marker.radius, withAlertRadiusText: true)
                Marker(radiusText, coordinate: marker.coordinate)
            }
            
            // MARK: - Routes
            let routes: [MKRoute] = mapVM.markers.compactMap { $0.route }
            ForEach(routes, id: \.self) { route in
                let isFirst: Bool = routes.first == route
                
                MapPolyline(route)
                    .stroke(isFirst ? .pink : Color.debug, lineWidth: 3)
            }
        }
        .mapStyle(settingsVM.selectedMapStyle.mapStyle)
        .mapControls { mapControls }
        .mapControlVisibility(mapVM.showMapControls() ? .visible : .hidden)
        .onMapCameraChange(frequency: .continuous) { mapVM.onContinuousPrimaryMapCameraChange($0) }
        .onMapCameraChange(frequency: .onEnd) { mapVM.onPrimaryMapCameraChangeEnd($0) }
        .onAppear { mapVM.onMapViewAppear() }
        .onDisappear { mapVM.onMapViewDisappear() }
        .sheet(isPresented: .constant(true)) { MultipleStopsMapSheetView() }
    }
}

// MARK: - PREVIEWS
#Preview("ContentView") {
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
    }
}
