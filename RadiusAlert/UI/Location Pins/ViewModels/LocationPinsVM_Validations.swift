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
    
    func showScrollableHorizontalLocationPins() -> Bool {
        return !locationPinsArray.isEmpty
    }
    
    func showLocationPinOnPopupCard(item: PopupCardModel, state: PopupCardLocationPinStates) -> Bool {
        guard let coordinate: CLLocationCoordinate2D = mapVM.getMarkerObject(on: item.markerID)?.coordinate else { return false }
        
        let condition1: Bool = locationPinsArray.contains(where: { $0.isSameCoordinate(coordinate) })
        let condition2: Bool = item.locationTitle.isNil()
        let condition3: Bool = state == .none
        
        return (!condition1 && !condition2) || (condition1 && !condition3)
    }
    
    func disableLocationPinOnPopupCard(item: PopupCardModel, state: PopupCardLocationPinStates) -> Bool {
        let condition1: Bool = showLocationPinOnPopupCard(item: item, state: state)
        let condition2: Bool = (state == .none)
        
        return !condition1 || !condition2
    }
}
