//
//  RadiusAlertModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import CoreLocation

struct RadiusAlertModel: Hashable {
    var markerID: String { markerCoordinate.markerID() }
    var locationTitle: String?
    let firstUserLocation: CLLocationCoordinate2D
    let markerCoordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    let firstDate: Date = Date.now
    
    // Implement Equatable manually
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.markerID == rhs.markerID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(markerID)
    }
}
