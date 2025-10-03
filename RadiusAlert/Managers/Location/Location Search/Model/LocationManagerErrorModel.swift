//
//  LocationManagerErrorModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-10-03.
//

import Foundation

enum LocationManagerErrorModel {
    case failedCLGeoCoderOnRegionFilter(Error)
    case failedToGetCountry
    
    var errorDescription: String {
        switch self {
        case .failedCLGeoCoderOnRegionFilter(let error):
            return "❌: Failed to filter results based on region. \(error.localizedDescription)"
            
        case  .failedToGetCountry:
            return "❌: Failed to get country from geoCorder placemarks."
        }
    }
}
