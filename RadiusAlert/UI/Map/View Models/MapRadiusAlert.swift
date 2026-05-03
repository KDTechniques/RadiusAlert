//
//  MapRadiusAlert.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-01-28.
//

import Foundation

// MARK: RADIUS ALERT

extension MapViewModel {
    /// Returns the radius alert item for the given marker id.
    func getRadiusAlertItem(markerID: String) -> RadiusAlertModel? {
        return radiusAlertItems.first(where: { $0.markerID == markerID })
    }
    
    /// Updates the radius alert item when its linked location pin changes.
    ///
    /// Keeps the alert item in sync by updating the location title.
    func updateRadiusAlertItemOnLocationPinChange(_ item: LocationPinsModel) {
        let markerID: String = item.coordinate.markerID()
        guard var radiusAlertItem: RadiusAlertModel = radiusAlertItems.first(where: { $0.markerID == markerID }) else { return }
        
        radiusAlertItem.locationTitle = item.title
        updateRadiusAlertItem(radiusAlertItem)
    }
}
