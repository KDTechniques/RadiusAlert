//
//  SavedLocationPinsVM_Bindings.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import SwiftUI
import CoreLocation

extension LocationPinsViewModel {
    func isPresentedSavedLocationsSheetBinding() -> Binding<Bool> {
        return .init(get: { self.isPresentedSavedLocationsSheet }, set: setIsPresentedSavedLocationsSheet)
    }
    
    func isPresentedLocationSavingSheetBinding() -> Binding<Bool> {
        return .init(get: { self.isPresentedLocationSavingSheet }, set: setIsPresentedLocationSavingSheet)
    }
    
    func newLocationPinTextFieldTextBinding() -> Binding<String> {
        return .init(get: { self.newLocationPinTextFieldText }, set: setNewLocationPinTextFieldText)
    }
    
    func newLocationPinRadiusBinding() -> Binding<CLLocationDistance> {
        return .init(get: { self.newLocationPinRadius }, set: setNewLocationPinRadius)
    }
    
    func editModeBinding() -> Binding<EditMode> {
        return .init(get: { self.editMode }, set: setEditMode)
    }
}
