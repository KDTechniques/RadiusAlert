//
//  SavedPinsViewModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-03.
//

import Foundation

@Observable
final class SavedPinsViewModel {
    // MARK: - ASSIGNED PROPERTIES
    private(set) var horizontalPinButtonsHeight: CGFloat?
    
    
    // MARK: - SETTERS
    func setHorizontalPinButtonsHeight(_ value: CGFloat) {
        horizontalPinButtonsHeight = value
    }
}
