//
//  MapVM_Subscribers.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation
import Combine
import CoreLocation

// MARK: SUBSCRIBERS

extension MapViewModel {
    /// Subscribes to changes in the location authorization status and repositions the map if authorized.
    func authorizationStatusSubscriber() {
        locationManager.$authorizationStatus$
            .dropFirst()
            .removeDuplicates()
        // Updates authorization state and may reposition the map if authorized.
            .sink {
                // Updates internal state based on current authorization status.
                self.setIsAuthorizedToGetMapCameraUpdate($0 == .authorizedAlways || $0 == .authorizedWhenInUse)
                
                // Skips map update if not authorized.
                guard self.isAuthorizedToGetMapCameraUpdate else { return }
                
                // Delays then repositions the map to the initial user location on the main actor.
                Task { @MainActor in
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    self.positionToInitialUserLocation(on: .primary, animate: true)
                }
            }
            .store(in: &cancellables)
    }
    
    func multipleStopsMedium_IsCameraDraggingSubscriber() {
        $multipleStopsMedium$.removeDuplicates()
            .combineLatest($isPrimaryCameraDragging$.removeDuplicates())
            .dropFirst()
            .debounce(for: .nanoseconds(/*60*/3_000_000_000), scheduler: DispatchQueue.main) // 1 min.
            .sink { medium, isDragging in
                guard medium == .manual && !isDragging else { return }
                self.resetMultipleStopsMedium()
            }
            .store(in: &cancellables)
    }
    
    func currentUserLocationSubscriber() {
        locationManager.$currentUserLocation$
            .compactMap { $0 } // Returns non-optional values because of `Compact Map`. So, no need of `guard let` statements
            .sink { location in
                self.setDistanceText(self.locationManager.distances.min() ?? .zero)
            }
            .store(in: &cancellables)
    }
    
    func primarySelectedRadiusSubscriber() {
        $primarySelectedRadius$
            .dropFirst()
            .map { $0.rounded() }
            .debounce(for: .nanoseconds(100_000_000), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { radius in
                self.setRegionBoundsOnRadius()
            }
            .store(in: &cancellables)
    }
}
