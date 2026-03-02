//
//  AudioRouteOutputTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-03-02.
//

import Foundation

enum AudioRouteOutputTypes: String, CaseIterable {
    case speaker = "Speaker"
    case bluetooth = "BluetoothA2DPOutput"
    case any
    
    var label: String {
        switch self {
        case .speaker:
            return "Built-in Speaker"
        case .bluetooth:
            return "Any Bluetooth Device"
        case .any:
            return "Any Device"
        }
    }
}
