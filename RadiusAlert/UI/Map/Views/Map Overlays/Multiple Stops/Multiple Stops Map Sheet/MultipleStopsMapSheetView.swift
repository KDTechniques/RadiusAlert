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
                
                if let centerCoordinate: CLLocationCoordinate2D = mapVM.secondaryCenterCoordinate,
                   showOverlays(),
                   !mapVM.isSecondaryCameraDragging {
                    MapCircle(center: centerCoordinate, radius: mapVM.secondarySelectedRadius)
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
            .mapControls { mapControls }
            .mapStyle(settingsVM.selectedMapStyle.mapStyle)
            .onMapCameraChange(frequency: .continuous) {
                mapVM.setSecondaryCameraDragging(true)
                mapVM.setSecondaryCenterCoordinate($0.region.center)
            }
            .onMapCameraChange(frequency: .onEnd) {
                mapVM.setSecondaryCameraDragging(false)
                mapVM.setSecondaryCenterCoordinate($0.region.center)
            }
            .overlay {
                Group {
                    MapPinView()
                    radiusSlider
                    
                    if !mapVM.isSecondaryCameraDragging {
                        CircularRadiusTextView(radius: mapVM.secondarySelectedRadius)
                    }
                }
                .opacity(showOverlays() ? 1 : 0)
                .disabled(!showOverlays())
                .animation(.default, value: showOverlays())
                
                MapStyleButtonView()
                    .mapBottomTrailingButtonsViewModifier
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if #available(iOS 26.0, *) {
                        Button("Done", role: .confirm) {
                            
                        }
                    } else {
                        Button("Done") {
                            
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    if #available(iOS 26.0, *) {
                        Button(role: .cancel) {
                            mapVM.setIsPresentedMultipleStopsMapSheet(false)
                        }
                    } else {
                        Button("Cancel") {
                            mapVM.setIsPresentedMultipleStopsMapSheet(false)
                        }
                    }
                }
            }
            .onChange(of: mapVM.secondarySelectedRadius) {
                setRegionBoundsOnRadius($1)
            }
            .navigationTitle("Add Another Stop")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            guard
                let position: MapCameraPosition = mapVM.locationManager.getInitialMapCameraPosition(),
                let region: MKCoordinateRegion = position.region else { return }
            
            mapVM.setSecondaryPosition(.region(region))
        }
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
        RadiusSliderView(value: mapVM.secondarySelectedRadiusBinding()) { print($0) }
            .frame(width: Utilities.screenWidth/MapValues.radiusSliderWidthFactor)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing, 10)
    }
    
    private func setRegionBoundsOnRadius(_ value: CLLocationDistance) {
        guard let centerCoordinate = mapVM.secondaryCenterCoordinate else { return }
        
        let boundMeters: CLLocationDistance = mapVM.getRegionBoundsMetersOnRadius(for: value)
        
        let region: MKCoordinateRegion = .init(
            center: centerCoordinate,
            latitudinalMeters: boundMeters,
            longitudinalMeters: boundMeters
        )
        
        withAnimation(.none) {
            mapVM.setSecondaryPosition(.region(region))
        }
    }
    
    private func showOverlays() -> Bool {
        return mapVM.isBeyondMinimumDistance(centerCoordinate: mapVM.secondaryCenterCoordinate)
    }
}
