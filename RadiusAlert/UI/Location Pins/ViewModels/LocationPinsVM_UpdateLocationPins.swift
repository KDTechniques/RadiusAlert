//
//  LocationPinsVM_UpdateLocationPins.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-08.
//

import CoreLocation

extension LocationPinsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Handles the "Done" action when updating a location pin.
    ///
    /// Updates the selected location pin with a new title and radius,
    /// saves the changes to the local database, refreshes the list,
    /// and updates related map data.
    ///
    /// - Parameters:
    ///   - item: The location pin being updated.
    ///   - title: The new title for the pin.
    ///   - radius: The new radius value.
    func onLocationPinUpdateDoneButtonAction(_ item: LocationPinsModel, title: String, radius: CLLocationDistance) async {
        guard !title.isEmpty,
              let itemIndex: Int = locationPinsArray.firstIndex(of: item) else { return }
        
        let tempItem: LocationPinsModel = item
        tempItem.title = title
        tempItem.radius = radius
        
        insertToLocationPinsArray(index: itemIndex, with: tempItem)
        
        try? await locationPinManager.updateLocationPins(locationPinsArray)
        try? await fetchNSetLocationPins()
        
        mapVM.updateMarkerOnLocationPinChange(tempItem)
        mapVM.updateRadiusAlertItemOnLocationPinChange(tempItem)
    }
}
