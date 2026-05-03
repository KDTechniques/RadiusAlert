//
//  LocationPinsVM_Validations.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import Foundation
import CoreLocation

extension LocationPinsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Determines whether the "More" button should be shown.
    func showMoreButton() -> Bool {
        return locationPinsArray.count >= 1
    }
    
    /// Returns whether the edit button in the location pin list sheet should be disabled.
    func isDisabledLocationPinListSheetEditButton() -> Bool {
        return canUpdateLocationPin
    }
    
    /// Returns whether the top leading buttons in the list sheet should be disabled.
    func isDisabledLocationPinListSheetTopLeadingButtons() -> Bool {
        return editMode == .active
    }
    
    /// Determines whether swipe gestures should be enabled in the list.
    func enableSwipeGestures() -> Bool {
        return editMode == .active
    }
    
    /// Determines whether the horizontal saved location pins should be shown.
    func showScrollableHorizontalLocationPins() -> Bool {
        return !locationPinsArray.isEmpty
    }
    
    /// Determines whether a location pin should be shown on a popup card.
    ///
    /// Checks if the pin already exists, if the title is valid, and the current state.
    func showLocationPinOnPopupCard(item: PopupCardModel, state: PopupCardLocationPinStates) -> Bool {
        guard let coordinate: CLLocationCoordinate2D = mapVM.getMarkerObject(on: item.markerID)?.coordinate else { return false }
        
        let condition1: Bool = locationPinsArray.contains(where: { $0.isSameCoordinate(coordinate) })
        let condition2: Bool = item.locationTitle.isNil()
        let condition3: Bool = state == .none
        
        return (!condition1 && !condition2) || (condition1 && !condition3)
    }
    
    /// Determines whether the location pin button on a popup card should be disabled.
    func disableLocationPinOnPopupCard(item: PopupCardModel, state: PopupCardLocationPinStates) -> Bool {
        let condition1: Bool = showLocationPinOnPopupCard(item: item, state: state)
        let condition2: Bool = (state == .none)
        
        return !condition1 || !condition2
    }
}
