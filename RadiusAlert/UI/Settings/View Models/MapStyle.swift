//
//  MapStyle.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation

// MARK: MAP STYLE

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func onMapStyleChange(_ style: MapStyleTypes) {
        userDefaultsManager.saveMapStyle(style.rawValue)
    }
    
    func onMapStyleButtonVisibilityChange(_ boolean: Bool) {
        userDefaultsManager.saveMapStyleButtonVisibility(showMapStyleButton)
        MapStyleButtonTipModel.isMapStyleButtonVisible = boolean
    }
    
    func invalidateMapStyleButtonTip() {
        mapStyleButtonTip.invalidate(reason: .actionPerformed)
    }
}
