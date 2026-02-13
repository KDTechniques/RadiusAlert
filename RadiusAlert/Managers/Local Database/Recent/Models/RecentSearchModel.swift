//
//  RecentSearchModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-29.
//

import MapKit
import SwiftData

@Model
final class RecentSearchModel: Identifiable {
    // MARK: - PROPERTIES
    @Attribute(.unique) var id: String
    var title: String
    var subtitle: String
    var coordinate: CLLocationCoordinate2D { return .init(latitude: latitude, longitude: longitude) }
    var timestamp: Date
    
    private var latitude: CLLocationDegrees
    private var longitude: CLLocationDegrees
    
    static let maxRecentSearchesCount: Int = 5
    
    // MARK: - INITIALIZER
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.id = title + subtitle
        self.title = title
        self.subtitle = subtitle
        latitude = coordinate.latitude
        longitude = coordinate.longitude
        timestamp = .now
    }
}
