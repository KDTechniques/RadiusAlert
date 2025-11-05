//
//  SavedLocationPinsModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import CoreLocation
import SwiftData

@Model
final class SavedLocationPinsModel {
    // MARK: - PROPERTIES
    @Attribute(.unique) var id: String = UUID().uuidString
    var title: String
    var radius: CLLocationDistance
    private var latitude: CLLocationDegrees
    private var longitude: CLLocationDegrees
    
    // MARK: - INITIALIZER
    init(title: String, radius: CLLocationDistance, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.radius = radius
        latitude = coordinate.latitude
        longitude = coordinate.longitude
    }
    
    // MARK: - FUNCTIONS
    func getCoordinate() -> CLLocationCoordinate2D {
        return .init(latitude: latitude, longitude: longitude)
    }
}
