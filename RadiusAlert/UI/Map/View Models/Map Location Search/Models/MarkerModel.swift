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
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance
    var route: MKRoute?
    var color: Color
    
    static var mock: [Self] {
        let object: Self =  .init(
            title: UUID().uuidString,
            coordinate: .init(latitude: .zero, longitude: .zero),
            radius: Double.random(in: 700...3000),
            route: nil,
            color: .debug
        )
        
        return .init(repeating: object, count: 10)
    }
}
