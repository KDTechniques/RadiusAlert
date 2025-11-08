//
//  LocationPinsVM_Validations.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import Foundation

extension LocationPinsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func showScrollableHorizontalLocationPinsContent() -> Bool {
        return !locationPinsArray.isEmpty && mapVM.isMarkerCoordinateNil()
    }
    
    func showMoreButton() -> Bool {
        return locationPinsArray.count >= 1
    }
    
    func isDisabledLocationPinListSheetEditButton() -> Bool {
        return canRenameLocationPin
    }
    
    func isDisabledLocationPinListSheetTopLeadingButtons() -> Bool {
       return editMode == .active
    }
    
    func enableSwipeGestures() -> Bool {
        return editMode == .active
    }
}
