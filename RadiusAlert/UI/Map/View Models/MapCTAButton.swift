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
    
    /// Returns the foreground color of the CTA button based on marker coordinate availability.
    /// - Returns: Green if no marker is set, red if a marker exists.
    func getCTAButtonForegroundColor() -> Color {
        isMarkerCoordinateNil() ? .green : .red
    }
    
    /// Returns the background color of the CTA button based on marker coordinate availability.
    /// The color uses a fixed opacity for visual consistency.
    /// - Returns: Semi-transparent green if no marker is set, semi-transparent red if a marker exists.
    func getCTAButtonBackgroundColor() ->  Color {
        let opacity: CGFloat = 0.2
        return isMarkerCoordinateNil() ? Color.green.opacity(opacity) : Color.red.opacity(opacity)
    }
    
    /// Handles the CTA button tap action by deciding whether to start or stop an alert.
    /// Starts an alert if no marker is present; otherwise, prompts user to confirm stopping the alert.
    func triggerCTAButtonAction() {
        isMarkerCoordinateNil() ? startAlert() : stopAlertConfirmation()
    }
    
    /// Prompts the user to confirm stopping the current alert when they select a new search result.
    /// If confirmed, stops the existing alert and sets a new alert at the selected coordinate.
    /// - Parameter item: The selected search completion item representing the new alert location.
    func stopAlertOnSearchResultListRowTapConfirmation(_ item: MKLocalSearchCompletion) {
        alertManager.alertItem = AlertTypes.stopAlertOnSubmit { [weak self] boolean in
            guard let self, boolean else { return }
            stopAlert()
            setSelectedSearchResultCoordinate(item)
        }
    }
    
    /// Stops the active alert by resetting interaction modes, stopping region monitoring,
    /// halting haptics and tones, resetting the map, and clearing alert UI.
    func stopAlert() {
        setInteractionModes([.all])
        locationManager.stopMonitoringRegion()
        alertManager.stopHaptic()
        alertManager.stopTone()
        resetMapToCurrentUserLocation()
        clearPopupCardItem()
        setRadiusAlertItem(nil)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Starts and sets a radius alert with all necessary validations and UI updates.
    /// Performs distance checks, sets marker coordinates, fetches directions, and monitors the region.
    private func startAlert() {
        // First go through validations before proceeding.
        guard
            startAlert_ValidateDistance(),
            let (distance, currentUserLocation): (CLLocationDistance, CLLocationCoordinate2D) = startAlert_GetDistanceNUserLocation(),
            startAlert_ValidateRadius(distance: distance)  else { return }
        
        // Restrict interaction modes to prevent map hovering after alert setup, improving performance.
        setInteractionModes([])
        
        // Set the marker coordinate and attempt to retrieve directions.
        setMarkerCoordinate()
        getRoute()
        
        // Adjust the camera to show both the marker and user location for better UX.
        centerRegionBoundsForMarkerNUserLocation()
        
        startAlert_PreparePopupCardItem(currentUserLocation: currentUserLocation)
        guard startAlert_StartMonitoringRegion() else { return }
        startAlert_OnRegionEntry()
    }
    
    /// Validate that the selected radius is beyond the minimum allowed distance.
    private func startAlert_ValidateDistance() -> Bool {
        guard isBeyondMinimumDistance() else {
            alertManager.alertItem = AlertTypes.radiusNotBeyondMinimumDistance
            return false
        }
        
        return true
    }
    
    /// Calculate the distance between the center coordinate and the current user location.
    /// - Returns: A tuple containing the distance and current user location, or nil if unavailable.
    private func startAlert_GetDistanceNUserLocation() -> (distance: CLLocationDistance, userLocation: CLLocationCoordinate2D)? {
        guard
            let centerCoordinate,
            let currentUserLocation = locationManager.currentUserLocation
        else {
            MapCTAButtonErrorModel.failedToGetDistance.errorDescription.debugLog()
            return nil
        }
        
        let distance: CLLocationDistance = Utilities.getDistance(
            from: centerCoordinate,
            to: currentUserLocation
        )
        
        return (distance, currentUserLocation)
    }
    
    /// Ensure the selected radius is less than the distance to avoid setting an alert when the user is already inside the radius.
    /// - Parameter distance: The distance between center coordinate and current user location.
    /// - Returns: True if the selected radius is less than the distance; otherwise false.
    private func startAlert_ValidateRadius(distance: CLLocationDistance) -> Bool {
        guard isSelectedRadiusLessThanDistance(distance: distance) else {
            MapCTAButtonErrorModel.userAlreadyInRadius.errorDescription.debugLog()
            return false
        }
        
        return true
    }
    
    /// Prepare the popup card item to display when the user reaches the alert radius.
    /// - Parameter currentUserLocation: The current user location coordinate.
    private func startAlert_PreparePopupCardItem(currentUserLocation: CLLocationCoordinate2D) {
        if let markerCoordinate {
            let radiusAlertItem = RadiusAlertModel(
                locationTitle: selectedSearchResult?.name,
                firstUserLocation: currentUserLocation,
                markerCoordinate: markerCoordinate,
                setRadius: selectedRadius
            )
            setRadiusAlertItem(radiusAlertItem)
        }
    }
    
    /// Start monitoring the defined region; stops alert if monitoring fails.
    /// - Returns: True if monitoring started successfully; otherwise false.
    private func startAlert_StartMonitoringRegion() -> Bool {
        guard locationManager.startMonitoringRegion(radius: selectedRadius) else {
            stopAlert()
            MapCTAButtonErrorModel.failedToStartMonitoringRegion.errorDescription.debugLog()
            return false
        }
        
        return true
    }
    
    /// Define actions to execute when the user enters the monitored region.
    private func startAlert_OnRegionEntry() {
        locationManager.onRegionEntry = { [weak self] in
            guard let self else {
                MapCTAButtonErrorModel.failedToExecuteOnRegionEntry.errorDescription.debugLog()
                return
            }
            
            alertManager.sendNotification()
            alertManager.playHaptic()
            alertManager.playTone()
            generateNSetPopupCardItem()
        }
    }
    
    /// Shows a confirmation alert when the user taps the Stop Alert button.
    /// If the user confirms, the active alert is stopped.
    private func stopAlertConfirmation() {
        alertManager.alertItem = AlertTypes.stopAlertHereConfirmation { [weak self] in
            self?.stopAlert()
        }
    }
}
