//
//  SavedLocationPinsVM_Bindings.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import SwiftUI

extension LocationPinsViewModel {
    func isPresentedSavedLocationsSheetBinding() -> Binding<Bool> {
        .init(get: { self.isPresentedSavedLocationsSheet }, set: setIsPresentedSavedLocationsSheet)
    }
    
    func isPresentedLocationSavingSheetBinding() -> Binding<Bool> {
        .init(get: { self.isPresentedLocationSavingSheet }, set: setIsPresentedLocationSavingSheet)
    }
}
