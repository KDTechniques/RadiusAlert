//
//  Utilities.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-10.
//

import CoreLocation

func calculateMidCoordinate(from coord1: CLLocationCoordinate2D, and coord2: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
    let midLatitude = (coord1.latitude + coord2.latitude) / 2
    let midLongitude = (coord1.longitude + coord2.longitude) / 2
    
    return .init(latitude: midLatitude, longitude: midLongitude)
}

func getDistance(from coordinate1: CLLocationCoordinate2D, to coordinate2: CLLocationCoordinate2D) -> CLLocationDistance {
    let location1: CLLocation = .init(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
    let location2: CLLocation = .init(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
    
    return location1.distance(from: location2)
}
