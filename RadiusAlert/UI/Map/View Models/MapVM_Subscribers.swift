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
            .sink { self.positionMapOnAuthorization(authorizationStatus: $0) }
            .store(in: &cancellables)
    }
    
    func currentUserLocationSubscriber() {
        locationManager.$currentUserLocation$
            .combineLatest($distanceText$)
            .throttle(for: .nanoseconds(500_000_000), scheduler: DispatchQueue.main, latest: true)
            .compactMap { $0 }
            .sink { _ in
                self.updateDistanceText()
                self.autoPositionMarkersNUserLocationRegionBounds()
                
            }
            .store(in: &cancellables)
    }
    
    func primarySelectedRadiusSubscriber() {
        $primarySelectedRadius$
            .dropFirst()
            .map { $0.rounded() }
            .debounce(for: .nanoseconds(100_000_000), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink {
                self.setRegionBoundsOnRadius(for: .primary, radius: $0)
            }
            .store(in: &cancellables)
    }
    
    func networkStatusSubscriber() {
        networkManager.$connectionState$
            .removeDuplicates()
            .sink { self.recoverRoutes(networkStatus: $0) }
            .store(in: &cancellables)
    }
}
