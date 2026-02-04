//
//  LocationPinsModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import CoreLocation
import SwiftData

@Model
final class LocationPinsModel {
    // MARK: - PROPERTIES
    @Attribute(.unique) var id: String = UUID().uuidString
    var order: Int
    var title: String
    var radius: CLLocationDistance
    var coordinate: CLLocationCoordinate2D { return .init(latitude: latitude, longitude: longitude) }
    private var latitude: CLLocationDegrees
    private var longitude: CLLocationDegrees
    
    static var mock: [LocationPinsModel] {
        [
            .init(order: 0, title: "💼 OneMac", radius: 700, coordinate: .init(latitude: 7.1234567, longitude: 80.1234567)),
            .init(order: 1, title: "🚏 Pettah Market", radius: 800, coordinate: .init(latitude: 1.1234567, longitude: 30.1234567)),
            .init(order: 2, title: "🛣️ Katunayake Highway Exit", radius: 1500, coordinate: .init(latitude: 5.1234567, longitude: 60.1234567))
        ]
    }
    
    // MARK: - INITIALIZER
    init(order: Int = 0, title: String, radius: CLLocationDistance, coordinate: CLLocationCoordinate2D) {
        self.order = order
        self.title = title
        self.radius = radius
        latitude = coordinate.latitude
        longitude = coordinate.longitude
    }
    
    // MARK: - FUNCTIONS
    func isSameCoordinate(_ coordinate:CLLocationCoordinate2D) -> Bool {
        return latitude == coordinate.latitude && longitude == coordinate.longitude
    }
}
