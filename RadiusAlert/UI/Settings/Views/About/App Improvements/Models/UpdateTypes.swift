//
//  UpdateTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import Foundation

enum UpdateTypes: CaseIterable {
    case whatsNew, future
    
    var navigationLinkString: String {
        switch self {
        case .future:
            return "Future Updates 📲"
            
        case .whatsNew:
            return "What's New ✨"
        }
    }
    
    var navigationTitle: String {
        switch self {
        case .future:
            return "Future Updates"
            
        case .whatsNew:
            return "What's New"
        }
    }
    
    var values: [UpdateTypeValues] {
        switch self {
        case .future:
            return UpdateTypeValues.futureUpdates
            
        case .whatsNew:
            return UpdateTypeValues.whatsNew
        }
    }
}
