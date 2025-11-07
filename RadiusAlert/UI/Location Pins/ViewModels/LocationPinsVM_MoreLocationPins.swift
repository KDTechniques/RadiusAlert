//
//  LocationPinsVM_MoreLocationPins.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import Foundation

extension LocationPinsViewModel {
    func getLocationPinListSheetTopBarLeadingButtonText() -> String {
        canRenameLocationPin ? "Cancel" : "Update"
    }
}
