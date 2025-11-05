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
    @Attribute(.unique) var id: String = UUID().uuidString
    var title: String
    var radius: CLLocationDistance
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, radius: CLLocationDistance, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.radius = radius
        self.coordinate = coordinate
    }
}
