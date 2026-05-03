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
    
    /// Persists the selected map style.
    /// - Parameter style: The chosen `MapStyleTypes` value to save.
    func onMapStyleChange(_ style: MapStyleTypes) {
        userDefaultsManager.saveMapStyle(style.rawValue)
    }
    
    /// Updates and persists the Map Style button visibility, and informs tip logic.
    /// - Parameter boolean: Whether the Map Style button should be visible.
    func onMapStyleButtonVisibilityChange(_ boolean: Bool) {
        userDefaultsManager.saveMapStyleButtonVisibility(showMapStyleButton)
        // Inform the tip system about current visibility so it can adjust guidance.
        MapStyleButtonTipModel.isMapStyleButtonVisible = boolean
    }
    
    /// Marks the Map Style button tip as completed/acted upon.
    /// - Note: Prevents the tip from reappearing after the associated action is performed.
    func invalidateMapStyleButtonTip() {
        mapStyleButtonTip.invalidate(reason: .actionPerformed)
    }
}
