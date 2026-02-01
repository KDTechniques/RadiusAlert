//
//  MapCTAButton.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI
import MapKit

// MARK: CALL-TO-ACTION BUTTON

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Returns the foreground color of the CTA button based on marker coordinate availability.
    /// - Returns: Green if no marker is set, red if a marker exists.
    func getCTAButtonForegroundColor() -> Color {
        !isThereAnyMarkerCoordinate() ? .green : .red
    }
    
    /// Returns the background color of the CTA button based on marker coordinate availability.
    /// The color uses a fixed opacity for visual consistency.
    /// - Returns: Semi-transparent green if no marker is set, semi-transparent red if a marker exists.
    func getCTAButtonBackgroundColor() ->  Color {
        let opacity: CGFloat = 0.2
        return !isThereAnyMarkerCoordinate() ? Color.green.opacity(opacity) : Color.red.opacity(opacity)
    }
    
    /// Handles the CTA button tap action by deciding whether to start or stop an alert.
    /// Starts an alert if no marker is present; otherwise, prompts user to confirm stopping the alert.
    func triggerCTAButtonAction() {
        guard isThereAnyMarkerCoordinate() else {
            startAlert(from: .primary)
            return
        }
        
        stopAlertConfirmationHandler { stopAlertConfirmation(for: $0) }
    }
    
    /// Starts and sets a radius alert with all necessary validations and UI updates.
    /// Performs distance checks, sets marker coordinates, fetches directions, and monitors the region.
    func startAlert(from type: MapTypes) {
        // First go through validations before proceeding.
        guard
            locationManager.checkLocationPermission(),
            startAlert_ValidateDistance(on: type),
            let (distance, userLocation) = startAlert_GetDistance(on: type),
            startAlert_ValidateRadius(on: type, distance: distance),
            startAlert_CheckAlwaysAllowPermission() else { return }
        
        // Request local push notification permission if needed
        /// We don't request notification permission at the time of requesting location permission to provide better user experience.
        alertManager.requestNotificationPermission()
        
        // Set the marker coordinate.
        guard let markerID: String = addMarkerCoordinate(from: type) else { return }
        
        // Restrict interaction modes to prevent map hovering after alert setup, improving performance.
        setInteractionModes([])
        
        // encapsulated region bounds
        setRegionBoundsToUserLocationNMarkers()
        setInitialDistanceText()
        
        //Retrieve directions.
        assignRoute(to: markerID)
        
        startAlert_PreparePopupCardItem(currentUserLocation: userLocation, markerID: markerID)
        guard startAlert_StartMonitoringRegion(markerID: markerID) else { return }
        
        onAlertStartEnded()
    }
    
    /// Prompts the user to confirm stopping the current alert when they select a new search result.
    /// If confirmed, stops the existing alert and sets a new alert at the selected coordinate.
    /// - Parameter item: The selected search completion item representing the new alert location.
    func stopAlertOnSearchResultListRowTapConfirmation(_ item: MKLocalSearchCompletion) {
        stopAlertConfirmationHandler { markerID in
            alertManager.showAlert(
                .stopAlertOnSubmit(viewLevel: .content) {
                    self.stopAlert(for: [markerID])
                    self.setSearchFieldFocused(false)
                    self.prepareSelectedSearchResultCoordinateOnMap(item)
                }
            )
        }
    }
    
    func stopAlertOnRecentSearchListRowTapConfirmation(_ item: RecentSearchModel) {
        stopAlertConfirmationHandler { markerID in
            alertManager.showAlert(
                .stopAlertOnSubmit(viewLevel: .content) {
                    self.stopAlert(for: [markerID])
                    self.setSearchFieldFocused(false)
                    self.prepareSelectedRecentSearchCoordinateOnMap(item)
                    
                }
            )
        }
    }
    
    /// Stops the active alert by resetting interaction modes, stopping region monitoring,
    /// halting haptics and tones, resetting the map, and clearing alert UI.
    func stopAlert(for markerIDs: [String]) {
        for id in markerIDs {
            removeMarker(for: id)
            stopAlert_StopMonitoringRegion(for: id)
            stopAlert_RemoveRadiusAlertItem(for: id)
        }
        
        setInteractionModes(markers.isEmpty ? [.all] : [])
        alertManager.stopHaptic()
        alertManager.stopTone()
        positionToInitialUserLocation(on: .primary, animate: true)
        clearPopupCardItem()
        setPopupCardItem(nil)
        setSelectedSearchResult(nil)
        Task { await textToSpeechManager.stopSpeak() }
        resetDistanceText()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Called at the end of the `startAlert` function to perform final operations after the alert has started.
    private func onAlertStartEnded() {
        Task {
            await HapticManager.shared.vibrate(type: .rigid)
            await SettingsTipModel.startAlertEvent.donate()
            await MapStyleButtonTipModel.startAlertEvent.donate()
        }
    }
    
    /// Checks whether the app has `Always Allow` location permission.
    /// - Returns: `true` if permission is granted as `.authorizedAlways`, otherwise `false`.
    private func startAlert_CheckAlwaysAllowPermission() -> Bool {
        guard locationManager.authorizationStatus == .authorizedAlways else {
            alertManager.showAlert(.locationPermissionDenied(viewLevel: .content))
            return false
        }
        
        return true
    }
    
    /// Validate that the selected radius is beyond the minimum allowed distance.
    private func startAlert_ValidateDistance(on type: MapTypes) -> Bool {
        let isBeyondMinimumDistanceCondition: Bool = {
            switch type {
            case .primary:
                return isBeyondMinimumDistance(centerCoordinate: primaryCenterCoordinate)
            case .secondary:
                return isBeyondMinimumDistance(centerCoordinate: secondaryCenterCoordinate)
            }
        }()
        
        let viewLevel: AlertViewLevels = {
            switch type {
            case .primary:
                return .content
            case .secondary:
                return .multipleStopsMapSheet
            }
        }()
        
        guard isBeyondMinimumDistanceCondition else {
            alertManager.showAlert(.radiusNotBeyondMinimumDistance(viewLevel: viewLevel))
            return false
        }
        
        return true
    }
    
    /// Calculate the distance between the map pin { center coordinate } and the current user location.
    /// - Returns: A tuple containing the distance and current user location, or nil if unavailable.
    private func startAlert_GetDistance(on type: MapTypes) -> (distance: CLLocationDistance, userLocation: CLLocationCoordinate2D)? {
        let coordinate: CLLocationCoordinate2D? = {
            switch type {
            case .primary:
                return primaryCenterCoordinate
            case .secondary:
                return secondaryCenterCoordinate
            }
        }()
        
        guard
            let mapPinCoordinate: CLLocationCoordinate2D = coordinate,
            let currentUserLocation = locationManager.currentUserLocation else {
            Utilities.log(MapCTAButtonErrorModel.failedToGetDistance.errorDescription)
            return nil
        }
        
        let distance: CLLocationDistance = Utilities.getDistance(
            from: mapPinCoordinate,
            to: currentUserLocation
        )
        
        return (distance, currentUserLocation)
    }
    
    /// Ensure the selected radius is less than the distance to avoid setting an alert when the user is already inside the radius.
    /// - Parameter distance: The distance between center coordinate and current user location.
    /// - Returns: True if the selected radius is less than the distance; otherwise false.
    private func startAlert_ValidateRadius(on type: MapTypes, distance: CLLocationDistance) -> Bool {
        guard isSelectedRadiusLessThanDistance(on: type, distance: distance) else {
            Utilities.log(MapCTAButtonErrorModel.userAlreadyInRadius.errorDescription)
            return false
        }
        
        return true
    }
    
    /// Prepares and sets up the radius alert card data when the user enters the alert radius.
    /// This method determines the display title and other details for the popup card.
    /// - Parameter currentUserLocation: The user’s current geographic coordinates.
    private func startAlert_PreparePopupCardItem(currentUserLocation: CLLocationCoordinate2D, markerID: String) {
        guard let marker: MarkerModel = markers.first(where: { $0.id == markerID }) else { return }
        
        // Tracks whether the marker coordinate exactly matches the selected search result's coordinate
        var coordinateCheck: Bool
        var locationTitle: String?
        
        if let selectedSearchResultCoordinate: CLLocationCoordinate2D = selectedSearchResult?.result.placemark.coordinate {
            coordinateCheck = marker.coordinate.isEqual(to: selectedSearchResultCoordinate)
            locationTitle = coordinateCheck ? selectedSearchResult?.result.name : nil
            
            print("Match?: ", coordinateCheck)
            print("\n\n")
        }
        
        // Create the RadiusAlertModel:
        // - If coordinates match, use the search result's name for the title
        // - Always store the user's first location, the marker coordinate, and the chosen radius
        let radiusAlertItem = RadiusAlertModel(
            locationTitle: locationTitle,
            firstUserLocation: currentUserLocation,
            markerCoordinate: marker.coordinate,
            setRadius: marker.radius
        )
        
        // Save this alert item so it can be displayed when the alert triggers
        insertRadiusAlertItem(radiusAlertItem)
    }
    
    /// Start monitoring the defined region; stops alert if monitoring fails.
    /// - Returns: True if monitoring started successfully; otherwise false.
    private func startAlert_StartMonitoringRegion(markerID: String) -> Bool {
        guard let marker: MarkerModel = getMarkerObject(on: markerID) else { return false}
        
        let region: RegionModel = .init(
            markerCoordinate: marker.coordinate,
            radius: marker.radius) {
                self.onRegionEntry(markerID: markerID)
            }
        
        guard locationManager.startMonitoringRegion(region: region) else {
            Utilities.log(MapCTAButtonErrorModel.failedToStartMonitoringRegion.errorDescription)
            return false
        }
        
        return true
    }
    
    private func onRegionEntry(markerID: String) {
        alertManager.sendNotification()
        generateNSetPopupCardItem(for: markerID)
        alertManager.playHaptic()
        Task {
            if settingsVM.spokenAlertValues.isOnSpokenAlert {
                let locationTitle: String? = getRadiusAlertItem(markerID: markerID)?.locationTitle
                await settingsVM.spokenAlertSpeakAction(with: locationTitle)
                alertManager.playTone(settingsVM.selectedTone.fileName)
                settingsVM.setToneVolumeToFade()
            } else {
                alertManager.playTone(settingsVM.selectedTone.fileName)
                settingsVM.setToneVolumeToFade()
            }
        }
    }
    
    /// Shows a confirmation alert when the user taps the Stop Alert button.
    /// If the user confirms, the active alert is stopped.
    private func stopAlertConfirmation(for markerID: String) {
        alertManager.showAlert(
            .stopSingleAlertConfirmation(viewLevel: .content) {
                self.stopAlert(for: [markerID])
            }
        )
    }
    
    private func stopAlert_RemoveRadiusAlertItem(for markerID: String) {
        guard let radiusAlertItem: RadiusAlertModel = getRadiusAlertItem(markerID: markerID) else { return }
        removeRadiusAlertItem(radiusAlertItem)
    }
    
    private func stopAlertConfirmationHandler(_ action: (_ markerID: String) -> Void) {
        if markers.count == 1 {
            guard let markerID: String = markers.first?.id else { return }
            action(markerID)
        } else {
            setIsPresentedMultipleStopsCancellationSheet(true)
        }
    }
    
    private func stopAlert_StopMonitoringRegion(for markerID: String) {
        guard let region: RegionModel = locationManager.regions.first(where: { $0.markerID == markerID }) else { return }
        locationManager.stopMonitoringRegion(for: region)
    }
}
