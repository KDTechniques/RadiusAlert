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
            setSearchFieldFocused(false)
            setSelectedSearchResultCoordinate(item)
        }.alert
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
        setSelectedSearchResult(nil)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Starts and sets a radius alert with all necessary validations and UI updates.
    /// Performs distance checks, sets marker coordinates, fetches directions, and monitors the region.
    private func startAlert() {
        // First go through validations before proceeding.
        guard
            startAlert_ValidateDistance(),
            let (distance, currentUserLocation): (CLLocationDistance, CLLocationCoordinate2D) = startAlert_GetDistanceNUserLocation(),
            startAlert_ValidateRadius(distance: distance),
            startAlert_CheckAlwaysAllowPermission() else { return }
        
        // Request local push notification permission if needed
        /// We don't request notification permission at the time of requesting location permission to provide better user experience.
        alertManager.requestNotificationPermission()
        
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
        Task { await HapticManager.shared.vibrate(type: .rigid) }
    }
    
    /// Checks whether the app has `Always Allow` location permission.
    /// - Returns: `true` if permission is granted as `.authorizedAlways`, otherwise `false`.
    private func startAlert_CheckAlwaysAllowPermission() -> Bool {
        guard locationManager.authorizationStatus == .authorizedAlways else {
            alertManager.alertItem = AlertTypes.locationPermissionDenied.alert
            return false
        }
        
        return true
    }
    
    /// Validate that the selected radius is beyond the minimum allowed distance.
    private func startAlert_ValidateDistance() -> Bool {
        guard isBeyondMinimumDistance() else {
            alertManager.alertItem = AlertTypes.radiusNotBeyondMinimumDistance.alert
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
            Utilities.log(MapCTAButtonErrorModel.failedToGetDistance.errorDescription)
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
            Utilities.log(MapCTAButtonErrorModel.userAlreadyInRadius.errorDescription)
            return false
        }
        
        return true
    }
    
    /// Prepares and sets up the radius alert card data when the user enters the alert radius.
    /// This method determines the display title and other details for the popup card.
    /// - Parameter currentUserLocation: The user’s current geographic coordinates.
    private func startAlert_PreparePopupCardItem(currentUserLocation: CLLocationCoordinate2D) {
        if let markerCoordinate {
            // Tracks whether the marker coordinate exactly matches the selected search result's coordinate
            var coordinateCheck: Bool =  false
            var locationTitle: String?
            
            if let selectedSearchResultCoordinate:  CLLocationCoordinate2D = selectedSearchResult?.placemark.coordinate {
                coordinateCheck = markerCoordinate.isEqual(to: selectedSearchResultCoordinate)
                locationTitle = coordinateCheck ? selectedSearchResult?.name : nil
            }
            
            // Create the RadiusAlertModel:
            // - If coordinates match, use the search result's name for the title
            // - Always store the user's first location, the marker coordinate, and the chosen radius
            let radiusAlertItem = RadiusAlertModel(
                locationTitle: locationTitle,
                firstUserLocation: currentUserLocation,
                markerCoordinate: markerCoordinate,
                setRadius: selectedRadius
            )
            
            // Save this alert item so it can be displayed when the alert triggers
            setRadiusAlertItem(radiusAlertItem)
        }
    }
    
    /// Start monitoring the defined region; stops alert if monitoring fails.
    /// - Returns: True if monitoring started successfully; otherwise false.
    private func startAlert_StartMonitoringRegion() -> Bool {
        guard locationManager.startMonitoringRegion(radius: selectedRadius) else {
            stopAlert()
            Utilities.log(MapCTAButtonErrorModel.failedToStartMonitoringRegion.errorDescription)
            return false
        }
        
        return true
    }
    
    /// Define actions to execute when the user enters the monitored region.
    private func startAlert_OnRegionEntry() {
        locationManager.onRegionEntry = { [weak self] in
            guard let self else {
                Utilities.log(MapCTAButtonErrorModel.failedToExecuteOnRegionEntry.errorDescription)
                return
            }
            
            alertManager.sendNotification()
            alertManager.playTone(settingsVM.selectedTone.fileName)
            alertManager.playHaptic()
            generateNSetPopupCardItem()
        }
    }
    
    /// Shows a confirmation alert when the user taps the Stop Alert button.
    /// If the user confirms, the active alert is stopped.
    private func stopAlertConfirmation() {
        alertManager.alertItem = AlertTypes.stopAlertHereConfirmation { [weak self] in
            self?.stopAlert()
        }.alert
    }
}
