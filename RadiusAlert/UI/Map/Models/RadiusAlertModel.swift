//
//  RadiusAlertModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import CoreLocation

struct RadiusAlertModel {
    let locationTitle: String?
    let firstUserLocation: CLLocationCoordinate2D
    let markerCoordinate: CLLocationCoordinate2D
    let setRadius: CLLocationDistance
    let firstDate: Date = Date.now
}
