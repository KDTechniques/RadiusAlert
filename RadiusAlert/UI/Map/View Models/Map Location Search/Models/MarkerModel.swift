//
//  MarkerModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-25.
//

import MapKit
import SwiftUI

struct MarkerModel: Identifiable, Hashable {
    var id: String { coordinate.markerID() }
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance
    let color: Color
    let number: Int
    
    // Implement Hashable manually
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    // Implement Equatable manually
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    static var mock: [Self] {
        var tempArray: [Self] = []
        
        (0...10).forEach { _ in
            let object: Self = .init(
                title: UUID().uuidString,
                coordinate: .init(latitude: Double.random(in: 0...50), longitude: Double.random(in: 0...50)),
                radius: Double.random(in: 700...3000),
                color: .debug,
                number: Int.random(in: 0...100)
            )
            
            tempArray.append(object)
        }
        
        return tempArray
    }
}
