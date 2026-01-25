//
//  MarkerModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-25.
//

import MapKit
import SwiftUI

struct MarkerModel: Identifiable {
    var id: String { coordinate.markerID() }
    let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance
    let route: MKRoute?
    var color: Color
}
