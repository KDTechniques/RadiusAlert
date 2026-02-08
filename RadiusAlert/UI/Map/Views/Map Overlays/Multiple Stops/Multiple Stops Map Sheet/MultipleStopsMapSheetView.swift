//
//  MultipleStopsMapSheetView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-25.
//

import SwiftUI
import MapKit
import CoreLocation

struct MultipleStopsMapSheetView: View {
    // MARK: - INJECTED PROPERTIERS
    @Environment(MapViewModel.self) private var mapVM
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - ASSIGNED PROPERTIERS
    @Namespace var mapSpace
    
    // MARK: - BODY
    var body: some View {
#if DEBUG
        //        let _ = Self._printChanges()
#endif
        
        NavigationView {
            Map(position: mapVM.secondaryPositionBinding(), scope: mapSpace) {
                UserAnnotation()
                
                // MARK: - Radius Circles
                MapFloatingCircleView(
                    centerCoordinate: mapVM.secondaryCenterCoordinate,
                    radius: mapVM.secondarySelectedRadius,
                    condition: mapVM.showSecondaryFloatingCircle()
                )
                
                MapMarkerCirclesView(markers: mapVM.markers)
                
                // MARK: - Markers
                MapMarkersView(markers: mapVM.markers)
                
                // MARK: - Routes
                MapRoutesView(markers: mapVM.markers)
            }
            .mapStyle(settingsVM.selectedMapStyle.mapStyle)
            .mapControls { mapControls }
            .onMapCameraChange(frequency: .continuous) { mapVM.onContinuousMapCameraChange(for: .secondary, $0) }
            .onMapCameraChange(frequency: .onEnd) { mapVM.onMapCameraChangeEnd(for: .secondary, $0) }
            .overlay { mapOverlays }
            .toolbar {
                addButton
                dismissButton
            }
            .alertViewModifier(at: .multipleStopsMapSheet)
            .navigationTitle("Add Another Stop")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear { mapVM.onMultipleStopsMapSheetAppear() }
        .onDisappear { mapVM.onMultipleStopsMapSheetDisappear() }
        .presentationDragIndicator(.visible)
    }
}

// MARK: - PREVIEWS
#Preview("MultipleStopsMapSheetView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            MultipleStopsMapSheetView()
        }
        .previewModifier()
}

// MARK: - EXTENSIONS
extension MultipleStopsMapSheetView {
    @ViewBuilder
    private var mapControls: some View {
        MapUserLocationButton(scope: mapSpace)
        MapPitchToggle(scope: mapSpace)
        MapCompass(scope: mapSpace)
    }
    
    private var radiusSlider: some View {
        RadiusSliderView(value: mapVM.secondarySelectedRadiusBinding()) { mapVM.onRadiusSliderSlidingEnded(on: .secondary) }
            .frame(width: Utilities.screenWidth/MapValues.radiusSliderWidthFactor)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing, 10)
    }
    
    @ViewBuilder
    private var mapOverlays: some View {
        Group {
            MapPinView()
            radiusSlider
            
            if !mapVM.isSecondaryCameraDragging {
                CircularRadiusTextView(
                    radius: mapVM.secondarySelectedRadius,
                    title: mapVM.selectedSearchResult?.result.name
                )
            }
        }
        .opacity(mapVM.showSecondaryMapOverlays() ? 1 : 0)
        .disabled(!mapVM.showSecondaryMapOverlays())
        .animation(.default, value: mapVM.showSecondaryMapOverlays())
        
        MapStyleButtonView()
            .mapBottomTrailingButtonsViewModifier
    }
    
    private var addButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if #available(iOS 26.0, *) {
                Button("Add", role: .confirm) { mapVM.addAnotherStop() }
            } else {
                Button("Add") {  mapVM.addAnotherStop() }
            }
        }
    }
    
    private var dismissButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            if #available(iOS 26.0, *) {
                Button(role: .close) { mapVM.dismissMultipleStopsMapSheet() }
            } else {
                Button("Done") { mapVM.dismissMultipleStopsMapSheet() }
            }
        }
    }
}
