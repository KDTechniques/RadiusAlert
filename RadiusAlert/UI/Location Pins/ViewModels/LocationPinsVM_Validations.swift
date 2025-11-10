//
//  LocationPinsVM_Validations.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import Foundation

extension LocationPinsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func showMoreButton() -> Bool {
        return locationPinsArray.count >= 1
    }
    
    func isDisabledLocationPinListSheetEditButton() -> Bool {
        return canUpdateLocationPin
    }
    
    func isDisabledLocationPinListSheetTopLeadingButtons() -> Bool {
        return editMode == .active
    }
    
    func enableSwipeGestures() -> Bool {
        return editMode == .active
    }
    
    func showAddNewLocationPinButton() -> Bool {
        let condition1: Bool = mapVM.isBeyondMinimumDistance()
        let condition2: Bool = mapVM.isMarkerCoordinateNil()
        
        return condition1 && condition2
    }
    
    func showScrollableHorizontalLocationPins() -> Bool {
        return !locationPinsArray.isEmpty
    }
}
