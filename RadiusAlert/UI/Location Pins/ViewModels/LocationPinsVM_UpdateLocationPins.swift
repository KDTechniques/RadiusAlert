//
//  LocationPinsVM_UpdateLocationPins.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-08.
//

import CoreLocation

extension LocationPinsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func onLocationPinUpdateDoneButtonAction(_ item: LocationPinsModel, title: String, radius: CLLocationDistance) async {
        guard let itemIndex: Int = locationPinsArray.firstIndex(of: item) else { return }
        
        let tempItem: LocationPinsModel = item
        tempItem.title = title
        tempItem.radius = radius
        
        insertToLocationPinsArray(index: itemIndex, with: tempItem)
        
        try? await locationPinsManager.updateLocationPins(locationPinsArray)
        try? await fetchNSetLocationPins()
    }
}
