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
    
    /// Handles cancellation of a single stop in multiple stops mode.
    func handleMultipleStopsSingleCancellation(for markerID: String) {
        stopAlert(for: [markerID])
        setIsPresentedMultipleStopsCancellationSheet(!markers.isEmpty)
    }
    
    /// Handles cancel all stops action in multiple stops mode.
    func handleMultipleStopsCancellation() {
        alertManager.showAlert(
            .stopAllAlertsConfirmation(viewLevel: .multipleStopsCancellationSheet) {  [weak self] in
                guard let self else { return }
                
                let markerIDs: [String] = markers.map({ $0.id })
                stopAlert(for: markerIDs)
                setIsPresentedMultipleStopsCancellationSheet(false)
            }
        )
    }
    
    /// Adds another stop to the map (secondary flow).
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
    
    /// Called when the multiple stops sheet appears.
    ///
    /// Sets the initial camera position and updates region bounds.
    func onMultipleStopsMapSheetAppear() {
        guard
            let position: MapCameraPosition = locationManager.getInitialMapCameraPosition(),
            let region: MKCoordinateRegion = position.region else { return }
        
        setSecondaryPosition(.region(region))
        setRegionBoundsToUserLocationNMarkers(on: .secondary)
    }
    
    /// Called when the multiple stops sheet disappears.
    ///
    /// Restores region bounds back to the primary map.
    func onMultipleStopsMapSheetDisappear() {
        setRegionBoundsToUserLocationNMarkers(on: .primary)
    }
    
    /// Updates tip system state when multiple stops cancellation sheet visibility changes.
    func onChangeIsPresentedMultipleStopsCancellationSheet() {
        SettingsTipModel.isPresentedSheet = isPresentedMultipleStopsCancellationSheet
        MapStyleButtonTipModel.isPresentedSheet = isPresentedMultipleStopsCancellationSheet
    }
}
