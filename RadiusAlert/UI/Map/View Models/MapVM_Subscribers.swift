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
    // MARK: - PUBLIC FUNCTIONS
    
    /// Sets up a subscriber for location authorization changes.
    /// - Important: Drops the initial emission to avoid reacting to the boot-time state,
    ///   then removes duplicates so we only handle actual state transitions.
    ///   When authorization changes, we update internal state and, if authorized,
    ///   reposition the map accordingly.
    func authorizationStatusSubscriber() {
        // Ignore the initial value emitted on subscription (we only care about changes).
        locationManager.$authorizationStatus$
        // Prevent handling the same authorization state repeatedly.
            .dropFirst()
            .removeDuplicates()
        // React to new authorization values and update the map as needed.
            .sink {  [weak self] in
                guard let self else { return }
                positionMapOnAuthorization(authorizationStatus: $0)
            }
            .store(in: &cancellables)
    }
    
    /// Subscribes to user location and distance changes to keep UI and camera bounds updated.
    /// Combines the latest user location with `distanceText$` so distance-dependent logic
    /// recomputes together, throttles updates to reduce UI churn, and updates distance text
    /// and region bounds for user + markers.
    func currentUserLocationSubscriber() {
        locationManager.$currentUserLocation$
        // Recompute when either location or displayed distance changes.
            .combineLatest($distanceText$)
        // Limit updates to at most twice per second to avoid excessive UI work.
            .throttle(for: .seconds(0.5), scheduler: DispatchQueue.main, latest: true)
        // Ignore nil tuples; proceed only with valid combined values.
            .compactMap { $0 }
        // On each valid, throttled update, refresh distance and adjust camera bounds.
            .sink {  [weak self] _ in
                guard let self else { return }
                
                updateDistanceText()
                autoPositionMarkersNUserLocationRegionBounds()
            }
            .store(in: &cancellables)
    }
}

