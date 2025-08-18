//
//  ToneManagerErrorModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-18.
//

import Foundation

enum ToneManagerErrorModel {
    case failedToFindAudioFile
    case failedToInitializePlayer(Error)
    case failedToActivateAudioSession(Error)
    case failedToDeactivateAudioSession(Error)
    
    var errorDescription: String {
        switch self {
        case .failedToFindAudioFile:
            return "❌: Failed to find tone audio file in the bundle."
            
        case .failedToInitializePlayer(let error):
            return "❌: Failed to initialize player.: \(error.localizedDescription)"
            
        case .failedToActivateAudioSession(let error):
            return "❌: Failed to activate audio session.: \(error.localizedDescription)"
            
        case .failedToDeactivateAudioSession(let error):
            return "❌: Failed to deactivate audio session.: \(error.localizedDescription)"
        }
    }
}
