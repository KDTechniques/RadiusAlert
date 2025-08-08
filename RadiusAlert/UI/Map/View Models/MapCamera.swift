//
//  MapCamera.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import MapKit
import CoreLocation
import SwiftUI

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    func positionToInitialUserLocation() {
        guard let position: MapCameraPosition = locationManager.getInitialMapCameraPosition() else { return }
        self.position = position
    }
    
    func resetMapToCurrentUserLocation() {
        removeMarkerCoordinate()
        removeDirections()
        withAnimation { positionToInitialUserLocation() }
    }
    
    func onContinuousMapCameraChange(_ context: MapCameraUpdateContext) {
        setCameraDragging(true)
        setCenterCoordinate(context.camera.centerCoordinate)
    }
    
    func onMapCameraChangeEnd(_ context: MapCameraUpdateContext) {
        setCameraDragging(false)
        setCenterCoordinate(context.camera.centerCoordinate)
        centerRegionBounds()
    }
    
    func nextMapStyle() {
        let mapStylesArray: [MapStyleTypes] = MapStyleTypes.allCases
        guard let index: Int = mapStylesArray.firstIndex(where: { $0 == selectedMapStyle }) else { return }
        
        let nextIndex: Int = mapStylesArray.nextIndex(after: index)
        selectedMapStyle = mapStylesArray[nextIndex]
    }
    
    func setRegionBoundMeters(center: CLLocationCoordinate2D, meters: CLLocationDistance) {
        position = .region(.init(
            center: center,
            latitudinalMeters: meters,
            longitudinalMeters: meters
        ))
    }
    
    func centerRegionBounds() {
        guard let markerCoordinate, let currentUserLocation = locationManager.currentUserLocation else { return }
        
        let distance: CLLocationDistance = locationManager.getDistance(from: markerCoordinate, to: currentUserLocation)
        let boundsMeters: CLLocationDistance = distance * mapValues.regionBoundsFactor
        let midCoordinate: CLLocationCoordinate2D = calculateMidCoordinate(from: markerCoordinate, and: currentUserLocation)
        
        withAnimation {
            position = .region(.init(center: midCoordinate, latitudinalMeters: boundsMeters, longitudinalMeters: boundsMeters))
        }
    }
    
    func setInteractionModes(_ modes: MapInteractionModes) {
        interactionModes = modes
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setCameraDragging(_ boolean: Bool) {
        isCameraDragging = boolean
    }
}
