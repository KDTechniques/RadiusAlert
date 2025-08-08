//
//  MapCTAButton.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI
import MapKit

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    func getCTAButtonForegroundColor() -> Color {
        isMarkerCoordinateNil() ? .green : .red
    }
    
    func getCTAButtonBackgroundColor() ->  Color {
        let opacity: CGFloat = 0.2
        return isMarkerCoordinateNil() ? Color.green.opacity(opacity) : Color.red.opacity(opacity)
    }
    
    func triggerCTAButtonAction() {
        isMarkerCoordinateNil() ? startAlert() : stopAlertConfirmation()
    }
    
    func showCTAButton() -> Bool {
        let condition1: Bool = !(
            showSearchResults() ||
            showNoSearchResultsText() ||
            showSearchingCircularProgress()
        )
        
        let condition2: Bool = isSearchFieldFocused
        
        return condition1 && !condition2
    }
    
    func stopAlertOnSearchResultListRowTapConfirmation(_ item: MKMapItem) {
        alertManager.alertItem = AlertTypes.stopAlertOnSubmit { [weak self] boolean in
            guard let self, boolean else { return }
            stopAlert()
            setSelectedSearchResultCoordinate(item)
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func startAlert() {
        guard isBeyondMinimumDistance() else {
            alertManager.alertItem = AlertTypes.radiusNotBeyondMinimumDistance
            return
        }
        
        guard
            let centerCoordinate,
            let currentUserLocation = locationManager.currentUserLocation else { return }
        
        let distance: CLLocationDistance = locationManager.getDistance(
            from: centerCoordinate,
            to: currentUserLocation
        )
        
        guard selectedRadius < distance else {
            AlertManager.shared.alertItem = AlertTypes.alreadyInRadius
            return
        }
        
        setInteractionModes([])
        setMarkerCoordinate()
        getDirections()
        centerRegionBounds()
        
        guard locationManager.startMonitoringRegion(radius: selectedRadius) else {
            stopAlert()
            return
        }
        
        locationManager.onRegionEntry = { [weak self] in
            guard let self else { return }
            
            alertManager.sendNotification()
            alertManager.playHaptic()
            alertManager.playTone()
        }
    }
    
    private func stopAlert() {
        setInteractionModes([.all])
        locationManager.stopMonitoringRegion()
        alertManager.stopHaptic()
        alertManager.stopTone()
        resetMapToCurrentUserLocation()
    }
    
    private func stopAlertConfirmation() {
        alertManager.alertItem = AlertTypes.stopAlertHereConfirmation { [weak self] in
            self?.stopAlert()
        }
    }
}
