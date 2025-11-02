//
//  MapStyle.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func onMapStyleChange(_ style: MapStyleTypes) {
        userDefaultsManager.saveMapStyle(style.rawValue)
        invalidateMapStyleButtonTip()
    }
    
    func onMapStyleButtonVisibilityChange(_ boolean: Bool) {
        userDefaultsManager.saveMapStyleButtonVisibility(showMapStyleButton)
        MapStyleButtonTipModel.isMapStyleButtonVisible = boolean
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func invalidateMapStyleButtonTip() {
        mapStyleButtonTip.invalidate(reason: .actionPerformed)
    }
}
