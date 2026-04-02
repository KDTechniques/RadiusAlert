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
                stopAlertIfRegionMonitorFailure()
            }
            .store(in: &cancellables)
    }
}
