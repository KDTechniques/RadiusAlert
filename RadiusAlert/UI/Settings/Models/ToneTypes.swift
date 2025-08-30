//
//  ToneTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import Foundation

enum ToneTypes: String, CaseIterable {
    case defaultTone, tone2
    
    var name: String {
        switch self {
        case .defaultTone:
            return "Default"
            
        case .tone2:
            return "Chime"
        }
    }
    
    var fileName: String {
        switch self {
        case .defaultTone:
            return "defaultTone"
            
        case .tone2:
            return "chimeTone"
        }
    }
}
