//
//  LocationPinModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-03.
//

import CoreLocation

struct LocationPinModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let emoji: String?
    let coordinate: CLLocationCoordinate2D
    
    func getLabel() -> String {
        if let emoji {
            return "\(emoji) \(title)"
        } else {
            return title
        }
    }
    
    static var mock: [Self] {
        [
            .init(title: "OneMac", emoji: "💼", coordinate: .init(latitude: 7.1234567, longitude: 80.1234567)),
            .init(title: "Pettah Market", emoji: "🚏", coordinate: .init(latitude: 1.1234567, longitude: 30.1234567)),
            .init(title: "Katunayake Highway Exit", emoji: "🛣️", coordinate: .init(latitude: 5.1234567, longitude: 60.1234567)),
        ]
    }
}
