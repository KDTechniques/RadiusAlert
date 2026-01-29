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
        var tempArray: [Self] = []
        
        (0...10).forEach { _ in
            let object: Self = .init(
                title: UUID().uuidString,
                coordinate: .init(latitude: Double.random(in: 0...50), longitude: Double.random(in: 0...50)),
                radius: Double.random(in: 700...3000),
                route: nil,
                color: .debug
            )
            
            tempArray.append(object)
        }
        
        return tempArray
    }
}
