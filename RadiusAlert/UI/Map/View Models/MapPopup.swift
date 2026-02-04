//
//  MapPopup.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import CoreLocation
import SwiftUI

// MARK: POPUP

extension MapViewModel {
    // MARK: - PUBLIC FUNCTIONS
    /// Generates a PopupCardModel with updated radius, duration, and distance
    /// values for the current alert and sets it for display in the UI.
    func generateNSetPopupCardItem(for markerID: String) {
        // Get rid of any overlapping popup card items if exist and stop monitoring regions for them
        handleOverlappingRadiusAlertItems(without: markerID)
        
        guard let item: RadiusAlertModel = getRadiusAlertItem(markerID: markerID) else { return } // Ensure the valid alert item is available
        
        let radiusText: String = getRadiusTextString(item.setRadius, withAlertRadiusText: false) // Format the alert radius for display
        let duration: String = generateDurationText(item.firstDate) // Compute the duration since the alert's first recorded date
        
        // Calculate the user's distance to the alert's radius
        let distanceToRadius: CLLocationDistance = Utilities.getDistanceToRadius(
            userCoordinate: item.firstUserLocation,
            markerCoordinate: item.markerCoordinate,
            radius: item.setRadius)
        
        let distanceText: String = getRadiusTextString(distanceToRadius, withAlertRadiusText: false) // Format the calculated distance
        
        // Prepare a popup card model with the collected display values
        let popupCardItem: PopupCardModel = .init(
            markerID: markerID,
            typeNValue: [
                (.radius, radiusText),
                (.duration, duration),
                (.distance, distanceText)
            ],
            locationTitle: item.locationTitle
        )
        
        setPopupCardItem(popupCardItem) // Set the popup card item for display in the UI
    }
    
    func clearPopupCardItem() {
        setPopupCardItem(nil)
    }
    
    func reduceAlertToneVolumeOnScenePhaseChange() {
        guard popupCardItem != nil else { return }
        
        let absoluteVolume: Float = 0.5
        alertManager.setAbsoluteToneVolume(absoluteVolume)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    /// Returns a human-readable duration string (e.g., "1h 5min.") for the elapsed time since the given date.
    private func generateDurationText(_ date: Date) -> String {
        let interval = Date.now.timeIntervalSince(date) // Calculate seconds since the provided date
        let totalMinutes = Int(interval / 60) // Convert the interval to total minutes
        let hours = totalMinutes / 60 // Extract the hour component
        let minutes = totalMinutes % 60 // Extract the remaining minutes
        
        var duration: String {
            // Build a formatted string with hours and minutes as appropriate
            if hours > 0 {
                if minutes > 0 {
                    return "\(hours)h \(minutes)min."
                } else {
                    return "\(hours)h"
                }
            } else {
                return "\(minutes)min."
            }
        }
        
        return duration
    }
    
    private func handleOverlappingRadiusAlertItems(without markerID: String) {
        var didEnterRegionMarkerIDs: [String] = locationManager.regions.filter({ $0.didEnterRegion == true }).map({ $0.markerID })
        didEnterRegionMarkerIDs.removeAll(where: { $0 == markerID }) // Remove the did enter region marker ids without the current one.
        
        stopAlert(for: didEnterRegionMarkerIDs)
    }
}

