//
//  UserDefaultsManager_Map.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-28.
//

import Foundation

/// If the stored value is nil, we return true so the user can experience the feature by default.
/// If the user explicitly disables it, we preserve that choice.
///
/// Example:
/// ```swift
/// if defaults.object(forKey: keys.toneFade.rawValue).isNil() {
///     return true
/// }
/// ```

extension UserDefaultsManager {
    // MARK: - Map Style
    
    func getMapStyle() -> MapStyleTypes {
        guard
            let rawValue: String = defaults.string(forKey: UserDefaultKeys.mapStyle.rawValue),
            let mapStyle: MapStyleTypes = .init(rawValue: rawValue) else { return .standard }
        
        return mapStyle
    }
    
    func saveMapStyle(_ value: String) {
        defaults.set(value, forKey: UserDefaultKeys.mapStyle.rawValue)
    }
    
    // MARK: - Map Style Button
    func getMapStyleButtonVisibility() -> Bool {
        guard defaults.object(forKey: UserDefaultKeys.mapStyleButton.rawValue) != nil else { return true }
        return defaults.bool(forKey: UserDefaultKeys.mapStyleButton.rawValue)
    }
    
    func saveMapStyleButtonVisibility(_ value: Bool) {
        defaults.set(value, forKey: UserDefaultKeys.mapStyleButton.rawValue)
    }
}
