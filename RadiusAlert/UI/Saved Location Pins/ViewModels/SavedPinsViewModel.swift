//
//  SavedPinsViewModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-03.
//

import SwiftUI

@Observable
final class SavedPinsViewModel {
    // MARK: - ASSIGNED PROPERTIES
    private(set) var horizontalPinButtonsHeight: CGFloat?
    private(set) var isPresentedSavedLocationsSheet: Bool = false
    private(set) var isPresentedLocationSavingSheet: Bool = false
    private(set) var locationSavingSheetHeight: CGFloat = .zero
    
    // MARK: - SETTERS
    func setHorizontalPinButtonsHeight(_ value: CGFloat) {
        horizontalPinButtonsHeight = value
    }
    
    func setIsPresentedSavedLocationsSheet(_ value: Bool) {
        isPresentedSavedLocationsSheet = value
    }
    
    func setIsPresentedLocationSavingSheet(_ value: Bool) {
        isPresentedLocationSavingSheet = value
    }
    
    func setLocationSavingSheetHeight(_ value: CGFloat) {
        locationSavingSheetHeight = value
    }
}
