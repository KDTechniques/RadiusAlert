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
            MapFloatingCircleView(
                centerCoordinate: mapVM.primaryCenterCoordinate,
                radius: mapVM.primarySelectedRadius,
                condition: mapVM.showPrimaryFloatingCircle()
            )
            
            MapMarkerCirclesView(markers: mapVM.markers)
            
            // MARK: - Markers
            MapMarkersView(markers: mapVM.markers)
            
            // MARK: - Routes
            MapRoutesView(markers: mapVM.markers)
        }
        .mapStyle(settingsVM.selectedMapStyle.mapStyle)
        .mapControls { mapControls }
        .mapControlVisibility(mapVM.showPrimaryMapControls() ? .visible : .hidden)
        .onMapCameraChange(frequency: .continuous) { mapVM.onContinuousMapCameraChange(for: .primary, $0) }
        .onMapCameraChange(frequency: .onEnd) { mapVM.onMapCameraChangeEnd(for: .primary, $0) }
        .onAppear { mapVM.onMapViewAppear() }
        .onDisappear { mapVM.onMapViewDisappear() }
        .sheet(isPresented: mapVM.multipleStopsMapSheetBinding()) { MultipleStopsMapSheetView() }
        .sheet(isPresented: mapVM.multipleStopsCancellationSheetBinding()) { MultipleStopsCancellationSheetView(markers: mapVM.markers) }
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
