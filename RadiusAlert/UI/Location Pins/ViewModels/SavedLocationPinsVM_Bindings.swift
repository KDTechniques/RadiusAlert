//
//  SavedLocationPinsVM_Bindings.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import SwiftUI
import CoreLocation

extension LocationPinsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func isPresentedSavedLocationsSheetBinding() -> Binding<Bool> {
        return .init(
            get: { [weak self] in
                guard let self else { return false}
                return isPresentedSavedLocationsSheet
            }, set: setIsPresentedSavedLocationsSheet)
    }
    
    func isPresentedLocationSavingSheetBinding() -> Binding<Bool> {
        return .init(
            get: { [weak self] in
                guard let self else { return false}
                return isPresentedLocationSavingSheet
            }, set: setIsPresentedLocationSavingSheet)
    }
    
    func newLocationPinTextFieldTextBinding() -> Binding<String> {
        return .init(
            get: {  [weak self] in
                guard let self else { return ""}
                return newLocationPinTextFieldText
            }, set: setNewLocationPinTextFieldText)
    }
    
    func newLocationPinRadiusBinding() -> Binding<CLLocationDistance> {
        return .init(
            get: {  [weak self] in
                guard let self else { return .zero}
                return newLocationPinRadius
            }, set: setNewLocationPinRadius)
    }
    
    func editModeBinding() -> Binding<EditMode> {
        return .init(
            get: {  [weak self] in
                guard let self else { return .inactive}
                return editMode
            }, set: setEditMode)
    }
    
    func locationPinNavigationPathsArrayBinding() -> Binding<[LocationPinsModel]> {
        return .init(
            get: {  [weak self] in
                guard let self else { return []}
                return locationPinNavigationPathsArray
            }, set: setLocationPinNavigationPathsArray)
    }
}
