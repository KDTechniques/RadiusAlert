//
//  LocationSearchManagerErrorModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-22.
//

import Foundation

enum LocationSearchManagerErrorModel {
    case failedMKLocalSearchCompleter(Error)
    
    var errorDescription: String {
        switch self {
        case .failedMKLocalSearchCompleter(let error):
            return "❌: MapKit Local Search Completer failed with an error. \(error.localizedDescription)"
        }
    }
}
