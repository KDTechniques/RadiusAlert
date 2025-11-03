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
    private(set) var isPresentedSheet: Bool = false
    
    // MARK: - SETTERS
    func setHorizontalPinButtonsHeight(_ value: CGFloat) {
        horizontalPinButtonsHeight = value
    }
    
    func setIsPresentedSheet(_ value: Bool) {
        isPresentedSheet = value
    }
    
    func isPresentedSheetBinding() -> Binding<Bool> {
        .init(get: { self.isPresentedSheet }, set: setIsPresentedSheet)
    }
}
