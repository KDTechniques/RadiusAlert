//
//  MapVM_Subscribers.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation
import Combine
import CoreLocation
import MapKit

// MARK: SUBSCRIBERS

extension MapViewModel {
    /// Subscribes to changes in the location authorization status and repositions the map if authorized.
    func authorizationStatusSubscriber() {
        locationManager.$authorizationStatus$
            .dropFirst()
            .removeDuplicates()
        // Updates authorization state and may reposition the map if authorized.
            .sink {  [weak self] in
                guard let self else { return }
                positionMapOnAuthorization(authorizationStatus: $0)
            }
            .store(in: &cancellables)
    }
    
    func currentUserLocationSubscriber() {
        locationManager.$currentUserLocation$
            .combineLatest($distanceText$)
            .throttle(for: .nanoseconds(500_000_000), scheduler: DispatchQueue.main, latest: true)
            .compactMap { $0 }
            .sink {  [weak self] _ in
                guard let self else { return }
                
                updateDistanceText()
                autoPositionMarkersNUserLocationRegionBounds()
                
                // here......... /// if the distance between current user location and the marker is less than set radius, trigger the alert. So even if the region monitor fails we still show the alert without ever missing it.
                /// this is gonna be the last bug fix we ever do. then begins the cleaning.
            }
            .store(in: &cancellables)
    }
}
