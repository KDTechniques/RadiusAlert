//
//  HapticManagerErrorModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-17.
//

import Foundation

enum HapticManagerErrorModel {
    case failedToPlaySOSPattern(Error)
    case failedToStopHaptics(Error)
    case failedToStartHapticEngine(Error)
    
    var errorDescription: String {
        switch self {
        case .failedToPlaySOSPattern(let error):
            return "❌: Failed to play SOS pattern. \(error.localizedDescription)"
            
        case .failedToStopHaptics(let error):
            return "❌: Failed to stop haptic. \(error.localizedDescription)"
            
        case .failedToStartHapticEngine(let error):
            return "❌: Failed to start haptic engine. \(error.localizedDescription)"
        }
    }
}
