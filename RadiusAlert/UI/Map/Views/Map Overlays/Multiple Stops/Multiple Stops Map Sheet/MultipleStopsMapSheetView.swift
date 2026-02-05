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
                ForEach(mapVM.markers) { marker in
                    let radiusText: String = mapVM.getRadiusTextString(marker.radius, withAlertRadiusText: true)
                    Group {
                        if mapVM.markers.count == 1 {
                            Marker(radiusText, systemImage: "bell.and.waves.left.and.right.fill", coordinate: marker.coordinate)
                        } else {
                            Marker(radiusText, monogram: Text("\(marker.number)"), coordinate: marker.coordinate)
                        }
                    }
                    .tint(marker.color.gradient)
                }
                
                // MARK: - Routes
                ForEach(mapVM.markers) { marker in
                    if let route: MKRoute = marker.route {
                        MapPolyline(route)
                            .stroke(marker.color, lineWidth: 3)
                    }
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
                .opacity(mapVM.showSecondaryMapOverlays() ? 1 : 0)
                .disabled(!mapVM.showSecondaryMapOverlays())
                .animation(.default, value: mapVM.showSecondaryMapOverlays())
                
                MapStyleButtonView()
                    .mapBottomTrailingButtonsViewModifier
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if #available(iOS 26.0, *) {
                        Button("Add", role: .confirm) {
                            guard mapVM.markers.count < 20 else {
                                mapVM.alertManager.showAlert(.maxMarkerLimitReached(viewLevel: .multipleStopsMapSheet))
                                
                                return
                            }
                            
                            mapVM.startAlert(from: .secondary)
                        }
                    } else {
                        Button("Add") {
                            guard mapVM.markers.count < 20 else {
                                mapVM.alertManager.showAlert(.maxMarkerLimitReached(viewLevel: .multipleStopsMapSheet))
                                
                                return
                            }
                            
                            mapVM.startAlert(from: .secondary)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    if #available(iOS 26.0, *) {
                        Button(role: .close) {
                            mapVM.setIsPresentedMultipleStopsMapSheet(false)
                        }
                    } else {
                        Button("Done") {
                            mapVM.setIsPresentedMultipleStopsMapSheet(false)
                        }
                    }
                }
            }
            .onChange(of: mapVM.secondarySelectedRadius) {
                setRegionBoundsOnRadius($1)
            }
            .alertViewModifier(at: .multipleStopsMapSheet)
            .navigationTitle("Add Another Stop")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear { // or use onFirst Appear if possible
            guard
                let position: MapCameraPosition = mapVM.locationManager.getInitialMapCameraPosition(),
                let region: MKCoordinateRegion = position.region else { return }
            
            mapVM.setSecondaryPosition(.region(region))
            mapVM.setRegionBoundsToUserLocationNMarkers(on: .secondary)
        }
        .onDisappear {
            mapVM.setRegionBoundsToUserLocationNMarkers(on: .primary)
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
}
