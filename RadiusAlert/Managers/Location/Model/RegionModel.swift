//
//  RegionModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-25.
//

import CoreLocation

struct RegionModel: Hashable {
    var markerID: String { markerCoordinate.markerID() }
    let markerCoordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance
    var monitor: CLCircularRegion?
    let onRegionEntry: () -> Void
    
    static func == (lhs: RegionModel, rhs: RegionModel) -> Bool {
        lhs.markerID == rhs.markerID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(markerID)
    }
}
