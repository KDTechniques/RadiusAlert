//
//  MapMultipleStops.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-05.
//

import SwiftUI
import MapKit

// MARK: MULTIPLE STOPS

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    func handleMultipleStopsSingleCancellation(for markerID: String) {
        stopAlert(for: [markerID])
        setIsPresentedMultipleStopsCancellationSheet(!markers.isEmpty)
    }
    
    func handleMultipleStopsCancellation() {
        alertManager.showAlert(
            .stopAllAlertsConfirmation(viewLevel: .multipleStopsCancellationSheet) {
                let markerIDs: [String] = self.markers.map({ $0.id })
                self.stopAlert(for: markerIDs)
                self.setIsPresentedMultipleStopsCancellationSheet(false)
            }
        )
    }
    
    func addAnotherStop() {
        guard markers.count < 20 else {
            alertManager.showAlert(
                .maxMarkerLimitReached(viewLevel: .multipleStopsMapSheet)
            )
            
            return
        }
        
        startAlert(from: .secondary)
    }
    
    func dismissMultipleStopsMapSheet() {
        setIsPresentedMultipleStopsMapSheet(false)
    }
    
    func onMultipleStopsMapSheetAppear() {
        guard
            let position: MapCameraPosition = locationManager.getInitialMapCameraPosition(),
            let region: MKCoordinateRegion = position.region else { return }
        
        setSecondaryPosition(.region(region))
        setRegionBoundsToUserLocationNMarkers(on: .secondary)
    }
    
    func onMultipleStopsMapSheetDisappear() {
        setRegionBoundsToUserLocationNMarkers(on: .primary)
    }
}
