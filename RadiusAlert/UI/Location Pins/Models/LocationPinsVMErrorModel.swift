//
//  LocationPinsVMErrorModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import Foundation

enum LocationPinsVMErrorModel: LocalizedError {
    case failedToInitializeLocationPinsVM(_: Error)
    case failedToCreateNewLocationPin(_: Error)
    
    var errorDescription: String? {
        switch self {
        case .failedToInitializeLocationPinsVM(let error):
            return "❌: Error initializing Location Pins View Model. \(error.localizedDescription)"

        case .failedToCreateNewLocationPin(let error):
            return "❌: Error creating a new location pin. \(error.localizedDescription)"
        }
    }
}
