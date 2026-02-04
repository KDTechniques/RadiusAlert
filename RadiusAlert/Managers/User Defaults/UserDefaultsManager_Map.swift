//
//  UserDefaultsManager_Map.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-28.
//

import Foundation

extension UserDefaultsManager {
    // MARK: - Map Style
    
    func getMapStyle() -> MapStyleTypes {
        guard
            let mapStyleRawValue: String = defaults.string(forKey: UserDefaultKeys.mapStyle.rawValue),
            let mapStyle: MapStyleTypes = MapStyleTypes.allCases.first(where: {$0.rawValue == mapStyleRawValue }) else { return .standard }
        
        return mapStyle
    }
    
    func saveMapStyle(_ value: String) {
        defaults.set(value, forKey: UserDefaultKeys.mapStyle.rawValue)
    }
    
    // MARK: - Map Style Button
    func getMapStyleButtonVisibility() -> Bool {
        if defaults.object(forKey: UserDefaultKeys.mapStyleButton.rawValue) == nil {
            return true
        } else {
            return defaults.bool(forKey: UserDefaultKeys.mapStyleButton.rawValue)
        }
    }
    
    func saveMapStyleButtonVisibility(_ value: Bool) {
        defaults.set(value, forKey: UserDefaultKeys.mapStyleButton.rawValue)
    }
}
